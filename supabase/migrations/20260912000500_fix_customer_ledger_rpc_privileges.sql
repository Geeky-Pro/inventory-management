BEGIN;

-- Controlled ledger RPCs must write with definer privileges because direct table writes
-- are intentionally revoked from authenticated clients. Authorization is still checked
-- explicitly inside each function.
ALTER FUNCTION public.add_customer_opening_balance(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT)
  SECURITY DEFINER;
ALTER FUNCTION public.record_customer_payment(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT)
  SECURITY DEFINER;

REVOKE ALL ON FUNCTION public.add_customer_opening_balance(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT) FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.record_customer_payment(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.add_customer_opening_balance(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION public.record_customer_payment(UUID,UUID,NUMERIC,TEXT,NUMERIC,DATE,TEXT,TEXT) TO authenticated;

COMMIT;