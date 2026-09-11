BEGIN;
DROP TRIGGER IF EXISTS trg_prevent_posted_invoice_delete ON public.purchase_invoices;
CREATE TRIGGER trg_prevent_posted_invoice_delete
BEFORE DELETE ON public.purchase_invoices
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_invoice_edit();
COMMIT;