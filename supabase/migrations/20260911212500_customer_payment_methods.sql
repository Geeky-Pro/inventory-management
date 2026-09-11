BEGIN;

ALTER TABLE public.debt_transactions
  DROP CONSTRAINT IF EXISTS debt_transactions_payment_method_check;

ALTER TABLE public.debt_transactions
  ADD CONSTRAINT debt_transactions_payment_method_check
  CHECK (
    payment_method IS NULL OR payment_method IN ('cash','transfer','check','other')
  );

CREATE OR REPLACE FUNCTION public.record_customer_payment(
  _operation_id UUID,_customer_id UUID,_amount_local NUMERIC,_currency_code TEXT,
  _exchange_rate NUMERIC,_transaction_date DATE,_payment_method TEXT,_notes TEXT DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql SECURITY INVOKER SET search_path=public,pg_temp AS $$
DECLARE v_user UUID:=auth.uid(); v_id UUID; v_balance NUMERIC; v_method TEXT:=lower(trim(_payment_method));
BEGIN
 IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
 IF NOT public.current_user_has_permission('customers.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
 IF _operation_id IS NULL OR _customer_id IS NULL OR _amount_local<=0 OR _exchange_rate<=0 THEN RAISE EXCEPTION 'Invalid payment'; END IF;
 IF v_method IS NULL OR v_method NOT IN ('cash','transfer','check','other') THEN RAISE EXCEPTION 'Invalid payment method'; END IF;
 IF NOT EXISTS(SELECT 1 FROM public.customers WHERE id=_customer_id) THEN RAISE EXCEPTION 'Customer not found'; END IF;
 PERFORM pg_advisory_xact_lock(hashtextextended(_customer_id::text,0));
 SELECT id INTO v_id FROM public.debt_transactions WHERE reference_table='customer_payments' AND reference_id=_operation_id AND customer_id=_customer_id LIMIT 1;
 IF v_id IS NOT NULL THEN RETURN v_id; END IF;
 SELECT COALESCE(SUM(CASE WHEN transaction_type='debit' THEN amount_local ELSE -amount_local END),0) INTO v_balance FROM public.debt_transactions WHERE customer_id=_customer_id;
 IF _amount_local>v_balance THEN RAISE EXCEPTION 'Payment exceeds outstanding customer balance'; END IF;
 INSERT INTO public.debt_transactions(customer_id,transaction_type,amount,currency_code,exchange_rate,amount_local,reference_table,reference_id,payment_method,notes,transaction_date,created_by)
 VALUES(_customer_id,'credit',_amount_local/_exchange_rate,_currency_code,_exchange_rate,_amount_local,'customer_payments',_operation_id,v_method,_notes,_transaction_date,v_user)
 RETURNING id INTO v_id; RETURN v_id;
END $$;

COMMIT;