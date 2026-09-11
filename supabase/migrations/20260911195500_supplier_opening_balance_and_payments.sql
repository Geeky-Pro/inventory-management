BEGIN;

CREATE OR REPLACE FUNCTION public.add_supplier_opening_balance(
  _operation_id UUID, _supplier_id UUID, _amount_local NUMERIC,
  _currency_code TEXT, _exchange_rate NUMERIC, _transaction_date DATE, _notes TEXT DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql SECURITY INVOKER SET search_path=public,pg_temp AS $$
DECLARE v_user UUID:=auth.uid(); v_id UUID;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('suppliers.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  IF _operation_id IS NULL OR _supplier_id IS NULL THEN RAISE EXCEPTION 'Operation and supplier are required'; END IF;
  IF _amount_local IS NULL OR _amount_local<=0 OR _exchange_rate IS NULL OR _exchange_rate<=0 THEN RAISE EXCEPTION 'Amount and exchange rate must be positive'; END IF;
  IF NOT EXISTS (SELECT 1 FROM public.suppliers WHERE id=_supplier_id) THEN RAISE EXCEPTION 'Supplier not found'; END IF;
  PERFORM pg_advisory_xact_lock(hashtextextended(_supplier_id::text,0));
  SELECT id INTO v_id FROM public.supplier_transactions WHERE reference_table='supplier_opening_balances' AND reference_id=_operation_id AND supplier_id=_supplier_id LIMIT 1;
  IF v_id IS NOT NULL THEN RETURN v_id; END IF;
  INSERT INTO public.supplier_transactions(supplier_id,transaction_type,amount,currency_code,exchange_rate,amount_local,reference_table,reference_id,notes,transaction_date,created_by)
  VALUES(_supplier_id,'debit',_amount_local/_exchange_rate,_currency_code,_exchange_rate,_amount_local,'supplier_opening_balances',_operation_id,_notes,_transaction_date,v_user)
  RETURNING id INTO v_id;
  RETURN v_id;
END $$;

CREATE OR REPLACE FUNCTION public.pay_supplier(
  _operation_id UUID, _supplier_id UUID, _amount_local NUMERIC,
  _currency_code TEXT, _exchange_rate NUMERIC, _transaction_date DATE,
  _payment_method TEXT, _notes TEXT DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql SECURITY INVOKER SET search_path=public,pg_temp AS $$
DECLARE v_user UUID:=auth.uid(); v_id UUID; v_balance NUMERIC;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('suppliers.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  IF _operation_id IS NULL OR _supplier_id IS NULL THEN RAISE EXCEPTION 'Operation and supplier are required'; END IF;
  IF _amount_local IS NULL OR _amount_local<=0 OR _exchange_rate IS NULL OR _exchange_rate<=0 THEN RAISE EXCEPTION 'Amount and exchange rate must be positive'; END IF;
  IF COALESCE(trim(_payment_method),'')='' THEN RAISE EXCEPTION 'Payment method is required'; END IF;
  PERFORM pg_advisory_xact_lock(hashtextextended(_supplier_id::text,0));
  SELECT id INTO v_id FROM public.supplier_transactions WHERE reference_table='supplier_payments' AND reference_id=_operation_id AND supplier_id=_supplier_id LIMIT 1;
  IF v_id IS NOT NULL THEN RETURN v_id; END IF;
  SELECT COALESCE(SUM(CASE WHEN transaction_type='debit' THEN amount_local ELSE -amount_local END),0)
  INTO v_balance FROM public.supplier_transactions WHERE supplier_id=_supplier_id;
  IF _amount_local > v_balance THEN RAISE EXCEPTION 'Payment exceeds outstanding supplier balance'; END IF;
  INSERT INTO public.supplier_transactions(supplier_id,transaction_type,amount,currency_code,exchange_rate,amount_local,reference_table,reference_id,payment_method,notes,transaction_date,created_by)
  VALUES(_supplier_id,'credit',_amount_local/_exchange_rate,_currency_code,_exchange_rate,_amount_local,'supplier_payments',_operation_id,_payment_method,_notes,_transaction_date,v_user)
  RETURNING id INTO v_id;
  RETURN v_id;
END $$;

REVOKE ALL ON FUNCTION public.add_supplier_opening_balance(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT) FROM PUBLIC,anon;
REVOKE ALL ON FUNCTION public.pay_supplier(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) FROM PUBLIC,anon;
GRANT EXECUTE ON FUNCTION public.add_supplier_opening_balance(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT) TO authenticated,service_role;
GRANT EXECUTE ON FUNCTION public.pay_supplier(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) TO authenticated,service_role;

COMMIT;