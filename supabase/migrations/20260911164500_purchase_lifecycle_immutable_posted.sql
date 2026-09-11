-- Phase 2: purchase lifecycle foundation and immutable posted invoices
BEGIN;

ALTER TABLE public.purchase_invoices
  ADD COLUMN IF NOT EXISTS status TEXT NOT NULL DEFAULT 'posted',
  ADD COLUMN IF NOT EXISTS voided_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS voided_by UUID REFERENCES public.profiles(id);

ALTER TABLE public.purchase_invoices
  DROP CONSTRAINT IF EXISTS purchase_invoices_status_check;

ALTER TABLE public.purchase_invoices
  ADD CONSTRAINT purchase_invoices_status_check
  CHECK (status IN ('posted','voided'));

ALTER TABLE public.purchase_invoice_items
  ADD CONSTRAINT purchase_invoice_items_quantity_positive
  CHECK (quantity > 0);

ALTER TABLE public.purchase_invoice_items
  ADD CONSTRAINT purchase_invoice_items_price_local_nonnegative
  CHECK (price_local >= 0);

ALTER TABLE public.purchase_invoice_items
  ADD CONSTRAINT purchase_invoice_items_line_total_local_nonnegative
  CHECK (line_total_local >= 0);

ALTER TABLE public.stock_movements
  DROP CONSTRAINT IF EXISTS stock_movements_movement_type_check;

ALTER TABLE public.stock_movements
  ADD CONSTRAINT stock_movements_movement_type_check
  CHECK (movement_type IN ('purchase','purchase_void','adjustment','opening'));

-- Posted invoices are immutable. Voiding is the only lifecycle transition.
CREATE OR REPLACE FUNCTION public.prevent_posted_invoice_edit()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
BEGIN
  IF OLD.status = 'posted' THEN
    IF TG_TABLE_NAME = 'purchase_invoices' THEN
      IF NEW.invoice_no IS DISTINCT FROM OLD.invoice_no
         OR NEW.invoice_date IS DISTINCT FROM OLD.invoice_date
         OR NEW.supplier_id IS DISTINCT FROM OLD.supplier_id
         OR NEW.payment_type IS DISTINCT FROM OLD.payment_type
         OR NEW.currency_code IS DISTINCT FROM OLD.currency_code
         OR NEW.exchange_rate IS DISTINCT FROM OLD.exchange_rate
         OR NEW.total_foreign IS DISTINCT FROM OLD.total_foreign
         OR NEW.total_local IS DISTINCT FROM OLD.total_local
         OR NEW.notes IS DISTINCT FROM OLD.notes
         OR NEW.created_by IS DISTINCT FROM OLD.created_by
         OR NEW.status IS DISTINCT FROM OLD.status
      THEN
        RAISE EXCEPTION 'Posted purchase invoices are immutable; void the invoice instead';
      END IF;
    ELSE
      RAISE EXCEPTION 'Posted purchase invoice lines are immutable; void the invoice instead';
    END IF;
  END IF;
  RETURN NEW;
END;
$function$;

DROP TRIGGER IF EXISTS trg_prevent_posted_invoice_edit ON public.purchase_invoices;
CREATE TRIGGER trg_prevent_posted_invoice_edit
BEFORE UPDATE ON public.purchase_invoices
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_invoice_edit();

DROP TRIGGER IF EXISTS trg_prevent_posted_invoice_item_edit ON public.purchase_invoice_items;
CREATE TRIGGER trg_prevent_posted_invoice_item_edit
BEFORE UPDATE ON public.purchase_invoice_items
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_invoice_edit();

DROP TRIGGER IF EXISTS trg_prevent_posted_invoice_item_delete ON public.purchase_invoice_items;
CREATE TRIGGER trg_prevent_posted_invoice_item_delete
BEFORE DELETE ON public.purchase_invoice_items
FOR EACH ROW
WHEN (OLD.invoice_id IS NOT NULL)
EXECUTE FUNCTION public.prevent_posted_invoice_edit();

-- Legacy delete trigger is incompatible with immutable posted history.
DROP TRIGGER IF EXISTS trg_invoice_item_stock_del ON public.purchase_invoice_items;

CREATE OR REPLACE FUNCTION public.void_purchase_invoice(_invoice_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
  v_user UUID := auth.uid();
BEGIN
  IF v_user IS NULL THEN
    RAISE EXCEPTION 'Authentication required';
  END IF;

  IF NOT public.current_user_has_permission('invoices.manage') THEN
    RAISE EXCEPTION 'Permission denied';
  END IF;

  SELECT *
  INTO v_invoice
  FROM public.purchase_invoices
  WHERE id = _invoice_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Purchase invoice not found';
  END IF;

  IF v_invoice.status = 'voided' THEN
    RAISE EXCEPTION 'Purchase invoice is already voided';
  END IF;

  INSERT INTO public.stock_movements (
    item_id, movement_type, quantity, unit_price_local,
    reference_table, reference_id, movement_date, notes, created_by
  )
  SELECT
    pii.item_id,
    'purchase_void',
    -(pii.quantity * COALESCE(pii.conversion_factor, 1)),
    CASE
      WHEN COALESCE(pii.conversion_factor, 1) > 0
      THEN pii.price_local / pii.conversion_factor
      ELSE pii.price_local
    END,
    'purchase_invoices',
    v_invoice.id,
    v_invoice.invoice_date,
    'Void purchase invoice',
    v_user
  FROM public.purchase_invoice_items pii
  WHERE pii.invoice_id = v_invoice.id;

  UPDATE public.purchase_invoices
  SET status = 'voided',
      voided_at = now(),
      voided_by = v_user,
      updated_by = v_user,
      updated_at = now()
  WHERE id = v_invoice.id;

  -- Recompute current latest purchase price for affected items from non-voided invoices.
  WITH affected AS (
    SELECT DISTINCT item_id
    FROM public.purchase_invoice_items
    WHERE invoice_id = v_invoice.id
  ),
  latest AS (
    SELECT DISTINCT ON (pii.item_id)
      pii.item_id,
      pii.price_local,
      pii.conversion_factor,
      pii.item_unit_id
    FROM public.purchase_invoice_items pii
    JOIN public.purchase_invoices pi ON pi.id = pii.invoice_id
    JOIN affected a ON a.item_id = pii.item_id
    WHERE pi.status = 'posted'
    ORDER BY pii.item_id, pi.invoice_date DESC, pi.created_at DESC, pii.created_at DESC
  )
  UPDATE public.items i
  SET last_purchase_price_local =
        CASE WHEN COALESCE(l.conversion_factor,1) > 0
             THEN l.price_local / COALESCE(l.conversion_factor,1)
             ELSE l.price_local END,
      updated_at = now()
  FROM latest l
  WHERE i.id = l.item_id;

  UPDATE public.items i
  SET last_purchase_price_local = 0,
      updated_at = now()
  WHERE EXISTS (SELECT 1 FROM affected a WHERE a.item_id = i.id)
    AND NOT EXISTS (SELECT 1 FROM latest l WHERE l.item_id = i.id);

  RETURN;
END;
$function$;

REVOKE ALL ON FUNCTION public.void_purchase_invoice(UUID) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.void_purchase_invoice(UUID) TO authenticated, service_role;

COMMIT;