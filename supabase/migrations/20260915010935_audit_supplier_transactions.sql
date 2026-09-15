CREATE TRIGGER audit_log_row_change
  AFTER INSERT OR UPDATE OR DELETE ON supplier_transactions
  FOR EACH ROW EXECUTE FUNCTION audit_log_row_change();
