-- Phase 1 security hardening
-- Restrict SECURITY DEFINER functions that are internal-only and harden mutable search paths.
-- Admin wrappers remain callable by the server-side service_role client only.

BEGIN;

-- Internal admin wrappers: never expose these through PostgREST/RPC to anon/authenticated.
REVOKE ALL ON FUNCTION public.admin_update_profile(uuid, uuid, text, text, boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.admin_update_profile(uuid, uuid, text, text, boolean) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.admin_update_profile(uuid, uuid, text, text, boolean) TO service_role;

REVOKE ALL ON FUNCTION public.admin_delete_user_data(uuid, uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.admin_delete_user_data(uuid, uuid) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.admin_delete_user_data(uuid, uuid) TO service_role;

-- Trigger-only functions: they are not application RPC endpoints.
REVOKE ALL ON FUNCTION public.audit_log_row_change() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.audit_log_row_change() FROM anon, authenticated;

REVOKE ALL ON FUNCTION public.handle_new_user() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.handle_new_user() FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO supabase_auth_admin;

-- This trigger function does not require elevated privileges.
ALTER FUNCTION public.prevent_currency_code_update()
  SECURITY INVOKER
  SET search_path = public, pg_temp;
REVOKE ALL ON FUNCTION public.prevent_currency_code_update() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.prevent_currency_code_update() FROM anon, authenticated;

-- This helper only changes a session-local setting and is invoked by the server-side
-- service-role client. It does not need SECURITY DEFINER.
ALTER FUNCTION public.set_audit_changed_by(uuid)
  SECURITY INVOKER
  SET search_path = public, pg_temp;
REVOKE ALL ON FUNCTION public.set_audit_changed_by(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.set_audit_changed_by(uuid) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.set_audit_changed_by(uuid) TO service_role;

-- Harden helper function search paths.
ALTER FUNCTION public.audit_log_diff(jsonb, jsonb)
  SET search_path = public, pg_temp;

COMMIT;
