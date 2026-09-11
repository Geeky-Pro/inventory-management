BEGIN;

-- Purchase creation is now a single database transaction. It validates the
-- authenticated caller, inserts the header and lines, and lets the existing
-- INSERT trigger create the authoritative purchase stock movements.
CREATE OR REPLACE FUNCTION public.create_purchase_invoice(
  _invoice_no TEXT,
  _invoice_date DATE,
  _supplier_id UUID,
  _payment_type TEXT,
  _currency_code TEXT,
  _exchange_rate NUMERIC,
  _total_foreign NUMERIC,
  _total_local NUMERIC,
  _notes TEXT,
  _items JSONB
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
DECLARE
  v_user UUID := auth.uid();
  v_invoice_id UUID;
  v_item JSONB;
  v_item_id UUID;
  v_item_unit_id UUID;
  v_quantity NUMERIC;
  v_price NUMERIC;
  v_conversion NUMERIC;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('invoices.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;

  IF COALESCE(trim(_invoice_no), '') = '' THEN RAISE EXCEPTION 'Invoice number is required'; END IF;
  IF _invoice_date IS NULL THEN RAISE EXCEPTION 'Invoice date is required'; END IF;
  IF _exchange_rate IS NULL OR _exchange_rate <= 0 THEN RAISE EXCEPTION 'Exchange rate must be positive'; END IF;
  IF _total_foreign < 0 OR _total_local < 0 THEN RAISE EXCEPTION 'Invoice totals cannot be negative'; END IF;
  IF jsonb_typeof(_items) <> 'array' OR jsonb_array_length(_items) = 0 THEN RAISE EXCEPTION 'At least one invoice item is required'; END IF;

  IF EXISTS (SELECT 1 FROM public.purchase_invoices WHERE invoice_no = _invoice_no) THEN
    RAISE EXCEPTION 'Invoice number already exists';
  END IF;

  INSERT INTO public.purchase_invoices (
    invoice_no, invoice_date, supplier_id, payment_type, currency_code,
    exchange_rate, total_foreign, total_local, notes, created_by, status
  ) VALUES (
    _invoice_no, _invoice_date, _supplier_id, _payment_type, _currency_code,
    _exchange_rate, _total_foreign, _total_local, _notes, v_user, 'posted'
  )
  RETURNING id INTO v_invoice_id;

  FOR v_item IN SELECT * FROM jsonb_array_elements(_items)
  LOOP
    v_item_id := (v_item->>'item_id')::UUID;
    v_item_unit_id := NULLIF(v_item->>'item_unit_id','')::UUID;
    v_quantity := (v_item->>'quantity')::NUMERIC;
    v_price := (v_item->>'price_local')::NUMERIC;
    v_conversion := COALESCE(NULLIF(v_item->>'conversion_factor','')::NUMERIC, 1);

    IF v_quantity IS NULL OR v_quantity <= 0 THEN RAISE EXCEPTION 'Quantity must be positive'; END IF;
    IF v_price IS NULL OR v_price < 0 THEN RAISE EXCEPTION 'Price cannot be negative'; END IF;
    IF v_conversion <= 0 THEN RAISE EXCEPTION 'Conversion factor must be positive'; END IF;

    IF NOT EXISTS (SELECT 1 FROM public.items WHERE id = v_item_id) THEN
      RAISE EXCEPTION 'Item not found';
    END IF;

    IF v_item_unit_id IS NOT NULL AND NOT EXISTS (
      SELECT 1 FROM public.item_units
      WHERE id = v_item_unit_id AND item_id = v_item_id
    ) THEN
      RAISE EXCEPTION 'Item unit does not belong to item';
    END IF;

    INSERT INTO public.purchase_invoice_items (
      invoice_id, item_id, item_unit_id, quantity, price_local,
      conversion_factor, line_total_local, created_by
    ) VALUES (
      v_invoice_id, v_item_id, v_item_unit_id, v_quantity, v_price,
      v_conversion, COALESCE((v_item->>'line_total_local')::NUMERIC, v_quantity * v_price),
      v_user
    );

    UPDATE public.items
    SET last_purchase_price_local = v_price / v_conversion,
        updated_at = now(),
        updated_by = v_user
    WHERE id = v_item_id;
  END LOOP;

  RETURN v_invoice_id;
END;
$function$;

REVOKE ALL ON FUNCTION public.create_purchase_invoice(TEXT,DATE,UUID,TEXT,TEXT,NUMERIC,NUMERIC,NUMERIC,TEXT,JSONB) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.create_purchase_invoice(TEXT,DATE,UUID,TEXT,TEXT,NUMERIC,NUMERIC,NUMERIC,TEXT,JSONB) TO authenticated, service_role;

-- Prevent direct clients from writing authoritative stock movements.
DROP POLICY IF EXISTS "perm write stock_movements" ON public.stock_movements;
DROP POLICY IF EXISTS "perm insert stock_movements" ON public.stock_movements;
DROP POLICY IF EXISTS "perm update stock_movements" ON public.stock_movements;
DROP POLICY IF EXISTS "perm delete stock_movements" ON public.stock_movements;

CREATE POLICY "stock movements read"
ON public.stock_movements FOR SELECT TO authenticated
USING (true);

COMMIT;