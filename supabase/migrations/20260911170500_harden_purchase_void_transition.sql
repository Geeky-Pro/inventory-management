BEGIN;

CREATE OR REPLACE FUNCTION public.prevent_posted_invoice_edit()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
BEGIN
  IF TG_TABLE_NAME = 'purchase_invoices' THEN
    IF TG_OP = 'DELETE' THEN
      RAISE EXCEPTION 'Purchase invoices are immutable; void the invoice instead';
    END IF;

    IF OLD.status = 'posted'
       AND NEW.status = 'voided'
       AND current_setting('app.purchase_voiding', true) = 'on'
       AND NEW.invoice_no IS NOT DISTINCT FROM OLD.invoice_no
       AND NEW.invoice_date IS NOT DISTINCT FROM OLD.invoice_date
       AND NEW.supplier_id IS NOT DISTINCT FROM OLD.supplier_id
       AND NEW.payment_type IS NOT DISTINCT FROM OLD.payment_type
       AND NEW.currency_code IS NOT DISTINCT FROM OLD.currency_code
       AND NEW.exchange_rate IS NOT DISTINCT FROM OLD.exchange_rate
       AND NEW.total_foreign IS NOT DISTINCT FROM OLD.total_foreign
       AND NEW.total_local IS NOT DISTINCT FROM OLD.total_local
       AND NEW.notes IS NOT DISTINCT FROM OLD.notes
       AND NEW.created_by IS NOT DISTINCT FROM OLD.created_by
    THEN
      RETURN NEW;
    END IF;

    IF OLD.status = 'posted' THEN
      RAISE EXCEPTION 'Posted purchase invoices are immutable; use the void operation';
    END IF;

    RAISE EXCEPTION 'Voided purchase invoices are immutable';
  END IF;

  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Purchase invoice lines are immutable and cannot be deleted';
  END IF;

  RAISE EXCEPTION 'Purchase invoice lines are immutable; void the invoice instead';
END;
$function$;

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

  PERFORM set_config('app.purchase_voiding', 'on', true);

  UPDATE public.purchase_invoices
  SET status = 'voided',
      voided_at = now(),
      voided_by = v_user,
      updated_by = v_user,
      updated_at = now()
  WHERE id = v_invoice.id;

  WITH affected AS (
    SELECT DISTINCT item_id
    FROM public.purchase_invoice_items
    WHERE invoice_id = v_invoice.id
  ),
  latest AS (
    SELECT DISTINCT ON (pii.item_id)
      pii.item_id,
      pii.price_local,
      pii.conversion_factor
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
END;
$function$;

COMMIT;