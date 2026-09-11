BEGIN;

-- Remove stale cloud grants that would otherwise conflict with the protected ledger model.
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON public.debt_transactions FROM anon, authenticated;
GRANT SELECT ON public.debt_transactions TO authenticated;

-- The generic mutation is retired: all new customer financial mutations must use controlled RPCs.
DROP FUNCTION IF EXISTS public.create_customer_transaction(UUID,TEXT,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT);

COMMIT;