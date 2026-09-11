BEGIN;
COMMENT ON FUNCTION public.adjust_stock(UUID,UUID,NUMERIC,NUMERIC,DATE,TEXT)
IS 'Atomic, permission-checked, serialized and idempotent stock adjustment. Negative resulting stock is rejected.';
COMMIT;