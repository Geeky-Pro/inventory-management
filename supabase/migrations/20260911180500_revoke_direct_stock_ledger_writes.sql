BEGIN;

-- stock_movements is an append-only ledger. No client role may mutate it directly.
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON TABLE public.stock_movements
FROM anon, authenticated;

GRANT SELECT ON TABLE public.stock_movements TO authenticated;

COMMIT;