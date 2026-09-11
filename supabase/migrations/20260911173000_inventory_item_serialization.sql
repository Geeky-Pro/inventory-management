BEGIN;

-- Inventory is derived from immutable stock movements.
-- Serialize writes per item and reject any purchase that would make stock negative.
CREATE OR REPLACE FUNCTION public.on_invoice_item_change()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $function$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
  v_factor NUMERIC(18,6) := COALESCE(NEW.conversion_factor, 1);
  v_base_qty NUMERIC(18,4);
  v_base_price NUMERIC(18,4);
  v_current NUMERIC(18,4);
BEGIN
  IF v_factor <= 0 OR NEW.quantity <= 0 THEN
    RAISE EXCEPTION 'Purchase quantity and conversion factor must be positive';
  END IF;

  SELECT * INTO v_invoice
  FROM public.purchase_invoices
  WHERE id = NEW.invoice_id
  FOR SHARE;

  IF v_invoice.status <> 'posted' THEN
    RAISE EXCEPTION 'Only posted purchase invoices can create stock movements';
  END IF;

  -- Transaction-level advisory lock prevents concurrent writes for the same item.
  PERFORM pg_advisory_xact_lock(hashtextextended(NEW.item_id::text, 0));

  v_base_qty := NEW.quantity * v_factor;
  v_base_price := NEW.price_local / v_factor;

  SELECT COALESCE(SUM(sm.quantity), 0)
  INTO v_current
  FROM public.stock_movements sm
  WHERE sm.item_id = NEW.item_id;

  -- Purchase is positive, so it cannot itself create negative stock.
  -- This lock establishes the serialization point used by future outbound
  -- movement functions as well.
  INSERT INTO public.stock_movements (
    item_id, movement_type, quantity, unit_price_local,
    reference_table, reference_id, movement_date, created_by
  ) VALUES (
    NEW.item_id, 'purchase', v_base_qty, v_base_price,
    'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by
  );

  UPDATE public.item_units
  SET last_purchase_price_local = NEW.price_local, updated_at = now()
  WHERE id = NEW.item_unit_id AND NEW.item_unit_id IS NOT NULL;

  UPDATE public.items
  SET last_purchase_price_local = v_base_price, updated_at = now()
  WHERE id = NEW.item_id;

  RETURN NEW;
END;
$function$;

-- Void must use the same per-item lock and must never allow stock to go below zero.
CREATE OR REPLACE FUNCTION public.void_purchase_invoice(_invoice_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
  v_user UUID := auth.uid();
  v_item RECORD;
  v_current NUMERIC(18,4);
BEGIN
  IF v_user IS NULL THEN RAISE EXCEPTION 'Authentication required'; END IF;
  IF NOT public.current_user_has_permission('invoices.manage') THEN RAISE EXCEPTION 'Permission denied'; END IF;

  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id = _invoice_id FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'Purchase invoice not found'; END IF;
  IF v_invoice.status = 'voided' THEN RAISE EXCEPTION 'Purchase invoice is already voided'; END IF;

  FOR v_item IN
    SELECT item_id, SUM(quantity * COALESCE(conversion_factor,1)) AS qty
    FROM public.purchase_invoice_items
    WHERE invoice_id = v_invoice.id
    GROUP BY item_id
  LOOP
    PERFORM pg_advisory_xact_lock(hashtextextended(v_item.item_id::text, 0));

    SELECT COALESCE(SUM(sm.quantity), 0) INTO v_current
    FROM public.stock_movements sm
    WHERE sm.item_id = v_item.item_id;

    IF v_current - v_item.qty < 0 THEN
      RAISE EXCEPTION 'Cannot void purchase: item % would result in negative stock', v_item.item_id;
    END IF;
  END LOOP;

  INSERT INTO public.stock_movements (
    item_id, movement_type, quantity, unit_price_local,
    reference_table, reference_id, movement_date, notes, created_by
  )
  SELECT pii.item_id,
         'purchase_void',
         -(pii.quantity * COALESCE(pii.conversion_factor,1)),
         CASE WHEN COALESCE(pii.conversion_factor,1) > 0
              THEN pii.price_local / pii.conversion_factor ELSE pii.price_local END,
         'purchase_invoices', v_invoice.id, v_invoice.invoice_date,
         'Void purchase invoice', v_user
  FROM public.purchase_invoice_items pii
  WHERE pii.invoice_id = v_invoice.id;

  PERFORM set_config('app.purchase_voiding', 'on', true);

  UPDATE public.purchase_invoices
  SET status='voided', voided_at=now(), voided_by=v_user, updated_by=v_user, updated_at=now()
  WHERE id=v_invoice.id;

  RETURN;
END;
$function$;

COMMIT;