BEGIN;

CREATE OR REPLACE VIEW public.supplier_statement
WITH (security_invoker=true)
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
    SUM(CASE WHEN st2.transaction_type='debit' THEN st2.amount_local ELSE -st2.amount_local END)
    OVER (
      PARTITION BY st.supplier_id
      ORDER BY st2.transaction_date, st2.created_at, st2.id
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 0
  ) AS running_balance_local
FROM public.supplier_transactions st
JOIN public.supplier_transactions st2
  ON st2.supplier_id = st.supplier_id
 AND (st2.transaction_date, st2.created_at, st2.id)
     <= (st.transaction_date, st.created_at, st.id);

GRANT SELECT ON public.supplier_statement TO authenticated;

CREATE INDEX IF NOT EXISTS idx_supplier_tx_statement_order
ON public.supplier_transactions(supplier_id, transaction_date, created_at, id);

COMMIT;