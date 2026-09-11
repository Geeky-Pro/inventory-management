-- Phase 1 security hardening: remove unauthenticated Data API access
BEGIN;

-- The application requires authentication before accessing the public schema.
-- RLS remains the row-level authorization boundary for authenticated users.
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM anon;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM anon;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM anon;

COMMIT;