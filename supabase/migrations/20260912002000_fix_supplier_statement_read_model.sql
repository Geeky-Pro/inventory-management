BEGIN;

-- The previous read model self-joined supplier_transactions to calculate the
-- running balance. That multiplied each statement row by the number of prior
-- transactions and inflated both displayed rows and running balances.
CREATE OR REPLACE VIEW public.supplier_statement
WITH (security_invoker = true)
AS
SELECT
  st.id,
  st.supplier_id,
  st.transaction_date,
  st.created_at,
  st.transaction_type,
  st.amount,
  st.currency_code,
  st.exchange_rate,
  st.amount_local,
  st.reference_table,
  st.reference_id,
  st.invoice_ref,
  st.payment_method,
  st.notes,
  st.created_by,
  COALESCE(
    SUM(
      CASE
        WHEN st.transaction_type = 'debit' THEN st.amount_local
        ELSE -st.amount_local
      END
    ) OVER (
      PARTITION BY st.supplier_id
      ORDER BY st.transaction_date, st.created_at, st.id
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ),
    0
  ) AS running_balance_local
FROM public.supplier_transactions st;

GRANT SELECT ON public.supplier_statement TO authenticated;

-- Keep payment values constrained at the database boundary as well as in the
-- Server Action. This prevents unsupported values from entering the ledger
-- through any future authenticated caller.
CREATE OR REPLACE FUNCTION public.pay_supplier(
  _operation_id UUID, _supplier_id UUID, _amount_local NUMERIC,
  _currency_code TEXT, _exchange_rate NUMERIC, _transaction_date DATE,
  _payment_method TEXT, _notes TEXT DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql SECURITY INVOKER
SET search_path=public,pg_temp AS $$
DECLARE
  v_user UUID:=auth.uid();
  v_id UUID;
  v_balance NUMERIC;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('suppliers.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  IF _operation_id IS NULL OR _supplier_id IS NULL THEN RAISE EXCEPTION 'Operation and supplier are required'; END IF;
  IF _amount_local IS NULL OR _amount_local<=0 OR _exchange_rate IS NULL OR _exchange_rate<=0 THEN
    RAISE EXCEPTION 'Amount and exchange rate must be positive';
  END IF;
  IF _transaction_date IS NULL THEN RAISE EXCEPTION 'Transaction date is required'; END IF;
  IF _payment_method NOT IN ('cash','transfer','check','other') THEN RAISE EXCEPTION 'Invalid payment method'; END IF;
  IF NOT EXISTS (SELECT 1 FROM public.suppliers WHERE id=_supplier_id) THEN RAISE EXCEPTION 'Supplier not found'; END IF;

  PERFORM pg_advisory_xact_lock(hashtextextended(_supplier_id::text,0));

  SELECT id INTO v_id
  FROM public.supplier_transactions
  WHERE reference_table='supplier_payments'
    AND reference_id=_operation_id
    AND supplier_id=_supplier_id
  LIMIT 1;
  IF v_id IS NOT NULL THEN RETURN v_id; END IF;

  SELECT COALESCE(SUM(CASE WHEN transaction_type='debit' THEN amount_local ELSE -amount_local END),0)
  INTO v_balance
  FROM public.supplier_transactions
  WHERE supplier_id=_supplier_id;

  IF _amount_local > v_balance THEN RAISE EXCEPTION 'Payment exceeds outstanding supplier balance'; END IF;

  INSERT INTO public.supplier_transactions(
    supplier_id,transaction_type,amount,currency_code,exchange_rate,amount_local,
    reference_table,reference_id,payment_method,notes,transaction_date,created_by
  )
  VALUES(
    _supplier_id,'credit',_amount_local/_exchange_rate,_currency_code,_exchange_rate,_amount_local,
    'supplier_payments',_operation_id,_payment_method,_notes,_transaction_date,v_user
  )
  RETURNING id INTO v_id;

  RETURN v_id;
END $$;

REVOKE ALL ON FUNCTION public.pay_supplier(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) FROM PUBLIC,anon;
GRANT EXECUTE ON FUNCTION public.pay_supplier(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) TO authenticated,service_role;

COMMIT;
