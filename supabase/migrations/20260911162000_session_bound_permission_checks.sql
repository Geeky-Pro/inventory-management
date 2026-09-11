-- Phase 1 security hardening: bind permission checks to the current session user
BEGIN;

CREATE OR REPLACE FUNCTION public.current_user_has_permission(_permission text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $function$
  SELECT public.has_permission(auth.uid(), _permission);
$function$;

REVOKE ALL ON FUNCTION public.current_user_has_permission(text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.current_user_has_permission(text) TO authenticated, service_role;

-- Rewrite existing RLS/Storage policies to use the session-bound helper.
DO $$
DECLARE
  p record;
  using_expr text;
  check_expr text;
BEGIN
  FOR p IN
    SELECT schemaname, tablename, policyname, qual, with_check
    FROM pg_policies
    WHERE (schemaname = 'public' OR schemaname = 'storage')
      AND (coalesce(qual,'') LIKE '%has_permission(auth.uid(),%'
           OR coalesce(with_check,'') LIKE '%has_permission(auth.uid(),%')
  LOOP
    using_expr := CASE
      WHEN p.qual IS NULL THEN NULL
      ELSE replace(p.qual, 'has_permission(auth.uid(),', 'current_user_has_permission(')
    END;
    check_expr := CASE
      WHEN p.with_check IS NULL THEN NULL
      ELSE replace(p.with_check, 'has_permission(auth.uid(),', 'current_user_has_permission(')
    END;

    IF using_expr IS NOT NULL THEN
      EXECUTE format(
        'ALTER POLICY %I ON %I.%I USING (%s)',
        p.policyname, p.schemaname, p.tablename, using_expr
      );
    END IF;

    IF check_expr IS NOT NULL THEN
      EXECUTE format(
        'ALTER POLICY %I ON %I.%I WITH CHECK (%s)',
        p.policyname, p.schemaname, p.tablename, check_expr
      );
    END IF;
  END LOOP;
END $$;

-- The old helper accepted an arbitrary UUID and therefore should no longer
-- be exposed as an application RPC endpoint. RLS now uses the session-bound helper.
REVOKE EXECUTE ON FUNCTION public.has_permission(uuid, text) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.is_admin(uuid) FROM PUBLIC, anon, authenticated;

-- is_admin is retained for backwards compatibility for trusted server-side use.
GRANT EXECUTE ON FUNCTION public.has_permission(uuid, text) TO service_role;
GRANT EXECUTE ON FUNCTION public.is_admin(uuid) TO service_role;

COMMIT;