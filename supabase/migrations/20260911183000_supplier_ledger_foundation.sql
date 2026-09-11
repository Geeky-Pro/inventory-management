BEGIN;

CREATE TABLE IF NOT EXISTS public.supplier_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id UUID NOT NULL REFERENCES public.suppliers(id) ON DELETE RESTRICT,
  transaction_type TEXT NOT NULL CHECK (transaction_type IN ('debit','credit')),
  amount NUMERIC(18,4) NOT NULL CHECK (amount > 0),
  currency_code TEXT NOT NULL REFERENCES public.currencies(code),
  exchange_rate NUMERIC(18,6) NOT NULL CHECK (exchange_rate > 0),
  amount_local NUMERIC(18,4) NOT NULL CHECK (amount_local > 0),
  reference_table TEXT,
  reference_id UUID,
  invoice_ref TEXT,
  payment_method TEXT,
  notes TEXT,
  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_by UUID REFERENCES public.profiles(id),
  updated_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_supplier_tx_supplier_date
ON public.supplier_transactions(supplier_id, transaction_date, created_at);

CREATE INDEX IF NOT EXISTS idx_supplier_tx_reference
ON public.supplier_transactions(reference_table, reference_id);

ALTER TABLE public.supplier_transactions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "supplier transactions read" ON public.supplier_transactions;
DROP POLICY IF EXISTS "supplier transactions write" ON public.supplier_transactions;
DROP POLICY IF EXISTS "supplier transactions update" ON public.supplier_transactions;
DROP POLICY IF EXISTS "supplier transactions delete" ON public.supplier_transactions;

CREATE POLICY "supplier transactions read"
ON public.supplier_transactions FOR SELECT TO authenticated
USING (public.current_user_has_permission('suppliers.view'));

REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON public.supplier_transactions FROM anon, authenticated;

GRANT SELECT ON public.supplier_transactions TO authenticated;

CREATE OR REPLACE VIEW public.supplier_balances
WITH (security_invoker = true)
AS
SELECT
  s.id AS supplier_id,
  s.name,
  s.phone,
  COALESCE(SUM(CASE WHEN st.transaction_type='debit' THEN st.amount_local ELSE 0 END),0) AS total_debit,
  COALESCE(SUM(CASE WHEN st.transaction_type='credit' THEN st.amount_local ELSE 0 END),0) AS total_credit,
  COALESCE(SUM(CASE WHEN st.transaction_type='debit' THEN st.amount_local ELSE -st.amount_local END),0) AS balance
FROM public.suppliers s
LEFT JOIN public.supplier_transactions st ON st.supplier_id=s.id
GROUP BY s.id, s.name, s.phone;

GRANT SELECT ON public.supplier_balances TO authenticated;

COMMIT;