BEGIN;

CREATE UNIQUE INDEX IF NOT EXISTS stock_movements_reference_item_once_idx
ON public.stock_movements (movement_type, reference_table, reference_id, item_id)
WHERE reference_table IS NOT NULL AND reference_id IS NOT NULL;

CREATE OR REPLACE FUNCTION public.adjust_stock(
  _operation_id UUID,
  _item_id UUID,
  _quantity_delta NUMERIC,
  _unit_price_local NUMERIC,
  _movement_date DATE,
  _notes TEXT DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $function$
DECLARE
  v_user UUID := auth.uid();
  v_current NUMERIC(18,4);
  v_id UUID;
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('items.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;
  IF _operation_id IS NULL THEN RAISE EXCEPTION 'Operation id is required'; END IF;
  IF _item_id IS NULL THEN RAISE EXCEPTION 'Item is required'; END IF;
  IF _quantity_delta IS NULL OR _quantity_delta = 0 THEN RAISE EXCEPTION 'Adjustment quantity cannot be zero'; END IF;
  IF _unit_price_local IS NULL OR _unit_price_local < 0 THEN RAISE EXCEPTION 'Unit price cannot be negative'; END IF;
  IF _movement_date IS NULL THEN RAISE EXCEPTION 'Movement date is required'; END IF;
  IF NOT EXISTS (SELECT 1 FROM public.items WHERE id = _item_id) THEN RAISE EXCEPTION 'Item not found'; END IF;

  PERFORM pg_advisory_xact_lock(hashtextextended(_item_id::text, 0));

  IF EXISTS (
    SELECT 1 FROM public.stock_movements
    WHERE movement_type='adjustment'
      AND reference_table='stock_adjustments'
      AND reference_id=_operation_id
      AND item_id=_item_id
  ) THEN
    SELECT id INTO v_id FROM public.stock_movements
    WHERE movement_type='adjustment'
      AND reference_table='stock_adjustments'
      AND reference_id=_operation_id
      AND item_id=_item_id;
    RETURN v_id;
  END IF;

  SELECT COALESCE(SUM(quantity),0) INTO v_current
  FROM public.stock_movements
  WHERE item_id=_item_id;

  IF v_current + _quantity_delta < 0 THEN
    RAISE EXCEPTION 'Adjustment would result in negative stock';
  END IF;

  INSERT INTO public.stock_movements (
    item_id, movement_type, quantity, unit_price_local,
    reference_table, reference_id, movement_date, notes, created_by
  ) VALUES (
    _item_id, 'adjustment', _quantity_delta, _unit_price_local,
    'stock_adjustments', _operation_id, _movement_date, _notes, v_user
  )
  RETURNING id INTO v_id;

  RETURN v_id;
END;
$function$;

REVOKE ALL ON FUNCTION public.adjust_stock(UUID,UUID,NUMERIC,NUMERIC,DATE,TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.adjust_stock(UUID,UUID,NUMERIC,NUMERIC,DATE,TEXT) TO authenticated, service_role;

-- The stock ledger remains append-only; clients may read but not write it directly.
ALTER TABLE public.stock_movements ENABLE ROW LEVEL SECURITY;

COMMIT;