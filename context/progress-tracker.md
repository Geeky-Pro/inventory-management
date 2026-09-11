# Progress Tracker — Inventory Management

> This is the one file that should keep changing. Update it after every
> meaningful work session — don't let it freeze while the code moves on.

## Last known-good reference point

Latest migrations recorded in the repo:
- `20260911160000_phase1_security_hardening.sql`
- `20260911161000_revoke_anon_public_schema_access.sql`

Both migrations were applied successfully to the Supabase project.

## Current Product Scope (confirmed 2026-09-11)

The system is intentionally scoped to one company/shop, one branch, and one warehouse.

- Inventory management.
- Purchase invoices only; no sales invoices for now.
- Purchase invoice lifecycle: `posted` / `voided`; no draft state.
- Inventory costing: latest purchase price.
- Negative stock is not allowed.
- Customer and supplier statements/balances.
- No full accounting module.
- No cash/bank-account management.
- No barcode/QR.
- No expiry dates, batches, or serial numbers.
- No returns yet.

These are deliberate scope decisions, not missing features.

## Phase 1 — Security Hardening

### Completed

- [x] Audited Supabase security posture and existing permission/RLS design.
- [x] Restricted internal admin wrappers:
  - `admin_update_profile` → `service_role` only.
  - `admin_delete_user_data` → `service_role` only.
- [x] Restricted trigger-only functions from public RPC execution.
- [x] Hardened relevant function `search_path` settings.
- [x] Changed `prevent_currency_code_update` and `set_audit_changed_by` to `SECURITY INVOKER`.
- [x] Removed tracked `.env` from the repository.
- [x] Hardened `.gitignore` for environment files.
- [x] Revoked all `anon` table/sequence/function privileges on the `public` schema.
- [x] Applied and verified:
  - `supabase/migrations/20260911160000_phase1_security_hardening.sql`
  - `supabase/migrations/20260911161000_revoke_anon_public_schema_access.sql`

### Phase 1 still in progress

- [ ] Review `has_permission` / `is_admin` SECURITY DEFINER design and ensure callers cannot use them as arbitrary user-identity checks.
- [ ] Complete RLS policy audit table-by-table, including INSERT/UPDATE/DELETE `WITH CHECK`.
- [ ] Review Storage policies and confirm whether Storage is actually used by the application.
- [ ] Determine whether `pg_graphql` is used; if not, consider disabling it rather than weakening application RLS.
- [ ] Enable Supabase Auth leaked-password protection in project settings.
- [ ] Rotate any real secrets that may have existed in the previously tracked `.env` (especially service-role credentials), because deleting the file does not erase Git history.

### Important security decisions

- Do not revoke `authenticated` access blindly: application access is protected by RLS and the fine-grained permission system.
- Do not weaken `has_permission` / `is_admin` until every RLS/caller dependency has been reviewed.
- Database changes must always be recorded as migrations under `supabase/migrations/` and applied to the live Supabase project.

## Phase 2 — Inventory Core

**Not started.** Do not begin until Phase 1 security hardening is complete.

Planned review:
- Items and units.
- Stock movement model.
- Current-stock consistency.
- Atomic purchase posting.
- Negative-stock enforcement at DB level.
- Latest-purchase-price costing.
- Stock adjustment/journal integrity.
- Void/reversal behavior.

## Phase 3 — Purchasing

**Not started.**

Planned:
- Purchase posting.
- Supplier balance integration.
- Void/reversal.
- Multi-unit purchase pricing.
- Currency/exchange-rate snapshots.

## Phase 4 — Customer Ledger

**Not started.**

Planned:
- Opening balances.
- Debit/credit transactions.
- Payments.
- Customer statements.
- Balance integrity.

## Phase 5 — Reports & UX

**Not started.**

Focus on reports that are useful for this shop rather than ERP/accounting features.

## Completed (pre-existing project work)

- 13 full pages under `_authenticated/`: dashboard, items, categories,
  units, suppliers, invoices (purchase), movements, customers, debts,
  users, permission-groups, audit-logs, reports, settings.
- Fine-grained RBAC at the individual-permission level.
- Multi-unit system with conversion factors.
- Multi-currency debt system.
- Audit trail restricted to `system.admin`.
- Excel/PDF export.
- Arabic/English RTL/LTR support.
- SSR-safe authentication/session fixes.
- Previous fixes for duplicate submissions, conflicting RLS policies,
  and trigger stack-overflow issues.
- `currencies.code` immutable after creation at DB level.
- Next.js migration phases 0–6 recorded as completed in the previous tracker.

## Open Questions / Follow-ups

- Profile avatar/WebP upload is still not present in the current code snapshot.
- `docs/ROUTES.md` may still need updating for `/audit-logs` and
  `/permission-groups`.
- Package manager/lockfile policy should remain consistent (npm lockfile is present).

## Change Log

### 2026-09-11 — Phase 1 Security Hardening
- Removed tracked `.env` and hardened `.gitignore`.
- Restricted internal Supabase functions and trigger functions.
- Hardened function search paths.
- Revoked anonymous access to the public schema.
- Added and applied two security migrations.
- Verified resulting function/table privileges.
- Phase 2 intentionally held until Phase 1 is complete.
