BEGIN;

CREATE OR REPLACE FUNCTION public.create_purchase_invoice(
  _invoice_no TEXT, _invoice_date DATE, _supplier_id UUID, _payment_type TEXT,
  _currency_code TEXT, _exchange_rate NUMERIC, _total_foreign NUMERIC,
  _total_local NUMERIC, _notes TEXT, _items JSONB
)
RETURNS UUID LANGUAGE plpgsql SECURITY INVOKER
SET search_path = public, pg_temp AS $function$
DECLARE
  v_user UUID := auth.uid(); v_invoice_id UUID; v_item JSONB;
  v_item_id UUID; v_item_unit_id UUID; v_quantity NUMERIC; v_price NUMERIC; v_conversion NUMERIC;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('invoices.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  IF _payment_type NOT IN ('cash','credit') THEN RAISE EXCEPTION 'Invalid payment type'; END IF;
  IF _supplier_id IS NULL THEN RAISE EXCEPTION 'Supplier is required'; END IF;
  IF NOT EXISTS (SELECT 1 FROM public.suppliers WHERE id=_supplier_id) THEN RAISE EXCEPTION 'Supplier not found'; END IF;
  IF _payment_type='credit' AND _supplier_id IS NULL THEN RAISE EXCEPTION 'Credit purchase requires supplier'; END IF;
  IF COALESCE(trim(_invoice_no),'')='' THEN RAISE EXCEPTION 'Invoice number is required'; END IF;
  IF _exchange_rate IS NULL OR _exchange_rate<=0 THEN RAISE EXCEPTION 'Exchange rate must be positive'; END IF;
  IF _total_foreign<0 OR _total_local<0 THEN RAISE EXCEPTION 'Invoice totals cannot be negative'; END IF;
  IF jsonb_typeof(_items)<>'array' OR jsonb_array_length(_items)=0 THEN RAISE EXCEPTION 'At least one invoice item is required'; END IF;
  IF EXISTS (SELECT 1 FROM public.purchase_invoices WHERE invoice_no=_invoice_no) THEN RAISE EXCEPTION 'Invoice number already exists'; END IF;

  INSERT INTO public.purchase_invoices(invoice_no,invoice_date,supplier_id,payment_type,currency_code,exchange_rate,total_foreign,total_local,notes,created_by,status)
  VALUES(_invoice_no,_invoice_date,_supplier_id,_payment_type,_currency_code,_exchange_rate,_total_foreign,_total_local,_notes,v_user,'posted')
  RETURNING id INTO v_invoice_id;

  FOR v_item IN SELECT * FROM jsonb_array_elements(_items) LOOP
    v_item_id := (v_item->>'item_id')::UUID;
    v_item_unit_id := NULLIF(v_item->>'item_unit_id','')::UUID;
    v_quantity := (v_item->>'quantity')::NUMERIC;
    v_price := (v_item->>'price_local')::NUMERIC;
    v_conversion := COALESCE(NULLIF(v_item->>'conversion_factor','')::NUMERIC,1);
    IF v_quantity IS NULL OR v_quantity<=0 THEN RAISE EXCEPTION 'Quantity must be positive'; END IF;
    IF v_price IS NULL OR v_price<0 THEN RAISE EXCEPTION 'Price cannot be negative'; END IF;
    IF v_conversion<=0 THEN RAISE EXCEPTION 'Conversion factor must be positive'; END IF;
    IF NOT EXISTS (SELECT 1 FROM public.items WHERE id=v_item_id) THEN RAISE EXCEPTION 'Item not found'; END IF;
    IF v_item_unit_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM public.item_units WHERE id=v_item_unit_id AND item_id=v_item_id) THEN RAISE EXCEPTION 'Item unit does not belong to item'; END IF;
    INSERT INTO public.purchase_invoice_items(invoice_id,item_id,item_unit_id,quantity,price_local,conversion_factor,line_total_local,created_by)
    VALUES(v_invoice_id,v_item_id,v_item_unit_id,v_quantity,v_price,v_conversion,COALESCE((v_item->>'line_total_local')::NUMERIC,v_quantity*v_price),v_user);
    UPDATE public.items SET last_purchase_price_local=v_price/v_conversion,updated_at=now(),updated_by=v_user WHERE id=v_item_id;
  END LOOP;

  IF _payment_type='credit' THEN
    INSERT INTO public.supplier_transactions(supplier_id,transaction_type,amount,currency_code,exchange_rate,amount_local,reference_table,reference_id,invoice_ref,notes,transaction_date,created_by)
    VALUES(_supplier_id,'debit',_total_foreign,_currency_code,_exchange_rate,_total_local,'purchase_invoices',v_invoice_id,_invoice_no,'Credit purchase',_invoice_date,v_user);
  END IF;

  RETURN v_invoice_id;
END; $function$;

CREATE OR REPLACE FUNCTION public.void_purchase_invoice(_invoice_id UUID)
RETURNS VOID LANGUAGE plpgsql SECURITY INVOKER
SET search_path=public,pg_temp AS $function$
DECLARE v_user UUID:=auth.uid(); v_invoice public.purchase_invoices%ROWTYPE; v_item RECORD; v_current NUMERIC;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('invoices.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id=_invoice_id FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'Purchase invoice not found'; END IF;
  IF v_invoice.status='voided' THEN RAISE EXCEPTION 'Purchase invoice is already voided'; END IF;
  FOR v_item IN SELECT item_id,SUM(quantity*COALESCE(conversion_factor,1)) qty FROM public.purchase_invoice_items WHERE invoice_id=v_invoice.id GROUP BY item_id LOOP
    PERFORM pg_advisory_xact_lock(hashtextextended(v_item.item_id::text,0));
    SELECT COALESCE(SUM(quantity),0) INTO v_current FROM public.stock_movements WHERE item_id=v_item.item_id;
    IF v_current-v_item.qty<0 THEN RAISE EXCEPTION 'Cannot void purchase: item % would result in negative stock',v_item.item_id; END IF;
  END LOOP;
  INSERT INTO public.stock_movements(item_id,movement_type,quantity,unit_price_local,reference_table,reference_id,movement_date,notes,created_by)
  SELECT item_id,'purchase_void',-(quantity*COALESCE(conversion_factor,1)),
         price_local/NULLIF(conversion_factor,0),'purchase_invoices',v_invoice.id,v_invoice.invoice_date,'Void purchase invoice',v_user
  FROM public.purchase_invoice_items WHERE invoice_id=v_invoice.id;
  IF v_invoice.payment_type='credit' THEN
    INSERT INTO public.supplier_transactions(supplier_id,transaction_type,amount,currency_code,exchange_rate,amount_local,reference_table,reference_id,invoice_ref,notes,transaction_date,created_by)
    VALUES(v_invoice.supplier_id,'credit',v_invoice.total_foreign,v_invoice.currency_code,v_invoice.exchange_rate,v_invoice.total_local,'purchase_invoices',v_invoice.id,v_invoice.invoice_no,'Void credit purchase',v_invoice.invoice_date,v_user);
  END IF;
  PERFORM set_config('app.purchase_voiding','on',true);
  UPDATE public.purchase_invoices SET status='voided',voided_at=now(),voided_by=v_user,updated_by=v_user,updated_at=now() WHERE id=v_invoice.id;
END; $function$;

COMMIT;