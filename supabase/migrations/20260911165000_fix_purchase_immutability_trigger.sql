-- Fix purchase immutability trigger semantics:
-- allow only posted -> voided on invoice header, and never delete/update invoice lines.
BEGIN;

CREATE OR REPLACE FUNCTION public.prevent_posted_invoice_edit()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $function$
BEGIN
  IF TG_TABLE_NAME = 'purchase_invoices' THEN
    IF OLD.status = 'posted'
       AND NEW.status = 'voided'
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
      RAISE EXCEPTION 'Posted purchase invoices are immutable; void the invoice instead';
    END IF;

    RAISE EXCEPTION 'Voided purchase invoices are immutable';
  END IF;

  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Purchase invoice lines are immutable and cannot be deleted';
  END IF;

  RAISE EXCEPTION 'Purchase invoice lines are immutable; void the invoice instead';
END;
$function$;

COMMIT;