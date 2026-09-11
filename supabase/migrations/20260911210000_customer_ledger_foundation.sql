BEGIN;

ALTER TABLE public.debt_transactions
  ADD COLUMN IF NOT EXISTS reference_table TEXT,
  ADD COLUMN IF NOT EXISTS reference_id UUID,
  ADD COLUMN IF NOT EXISTS payment_method TEXT;

CREATE INDEX IF NOT EXISTS idx_debt_reference
ON public.debt_transactions(reference_table, reference_id);

CREATE INDEX IF NOT EXISTS idx_debt_statement_order
ON public.debt_transactions(customer_id, transaction_date, created_at, id);

ALTER TABLE public.debt_transactions
  DROP CONSTRAINT IF EXISTS debt_transactions_amount_positive;
ALTER TABLE public.debt_transactions
  ADD CONSTRAINT debt_transactions_amount_positive CHECK (amount > 0);

ALTER TABLE public.debt_transactions
  DROP CONSTRAINT IF EXISTS debt_transactions_amount_local_positive;
ALTER TABLE public.debt_transactions
  ADD CONSTRAINT debt_transactions_amount_local_positive CHECK (amount_local > 0);

ALTER TABLE public.debt_transactions ENABLE ROW LEVEL SECURITY;
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON public.debt_transactions FROM anon, authenticated;
GRANT SELECT ON public.debt_transactions TO authenticated;

DROP POLICY IF EXISTS "debt transactions read" ON public.debt_transactions;
CREATE POLICY "debt transactions read"
ON public.debt_transactions FOR SELECT TO authenticated
USING (public.current_user_has_permission('customers.view'));

CREATE OR REPLACE VIEW public.customer_statement
WITH (security_invoker=true)
AS
SELECT
  st.id, st.customer_id, st.transaction_date, st.created_at,
  st.transaction_type, st.amount, st.currency_code, st.exchange_rate,
  st.amount_local, st.reference_table, st.reference_id, st.invoice_ref,
  st.payment_method, st.notes, st.created_by,
  COALESCE(SUM(CASE WHEN st2.transaction_type='debit' THEN st2.amount_local ELSE -st2.amount_local END)
    OVER (PARTITION BY st.customer_id
          ORDER BY st2.transaction_date,st2.created_at,st2.id
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) AS running_balance_local
FROM public.debt_transactions st
JOIN public.debt_transactions st2
 ON st2.customer_id=st.customer_id
AND (st2.transaction_date,st2.created_at,st2.id) <= (st.transaction_date,st.created_at,st.id);

GRANT SELECT ON public.customer_statement TO authenticated;

COMMIT;