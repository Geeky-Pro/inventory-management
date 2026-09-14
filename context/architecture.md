# Architecture — Inventory Management

## Stack (from the actual `package.json`)

| Layer | Technology |
|---|---|
| Framework | React 19.2 + Next.js 16.3 (App Router / SSR) |
| Bundler | Turbopack + TypeScript 5.8 |
| DB / Auth / Storage | Supabase (Postgres + RLS + Auth) — `@supabase/supabase-js` 2.106 |
| UI | Tailwind CSS v4 (CSS-first config) + shadcn/ui + Radix primitives |
| Forms | react-hook-form + zod |
| Export | jspdf / jspdf-autotable (PDF), xlsx (Excel) |
| Tests | vitest |
| Lint/Format | ESLint 9 (flat config) + typescript-eslint + Prettier |
| Package manager | **npm** — `package-lock.json` is the official source of truth. |

## File structure

- `src/app/` — Next.js App Router. Contains `layout.tsx`, `page.tsx`, and `(authenticated)/` route group for protected pages.
- `src/app/actions/` — Next.js Server Actions for secure database operations.
- `src/components/` — `AppHeader`, `AppSidebar`, `DataTable`, `ConfirmDelete`, `PageHeader` at the top level, and `src/components/ui/` for shadcn/Radix primitives.
- `src/lib/api/` — Shared server logic and additional actions (e.g., `admin.ts`).
- `src/lib/` — shared application logic, Supabase clients, permissions, i18n, exports, and utilities.
- `src/lib/supabase/` — browser/server Supabase clients; `src/integrations/supabase/types.ts` contains auto-generated schema types.
- `supabase/migrations/` — SQL files for database schema evolution.
- `supabase/migrations/` — 18 SQL files so far (latest: 2026-06-05).

## Database (20 tables actually, per `public_schema_tables.tsv`)

`audit_logs`, `categories`, `currencies`, `customer_balances`, `customers`,
`debt_transactions`, `exchange_rates`, `item_stock`, `items`,
`permission_group_items`, `permission_groups`, `permissions`, `profiles`,
`purchase_invoice_items`, `purchase_invoices`, `stock_movements`,
`suppliers`, `units`, `user_permission_groups`, `user_permissions`.

## Invariants — rules that must never be broken

1. **`SUPABASE_SERVICE_ROLE_KEY` must never be exposed to the client.**
   Only server actions use it. Anything that needs elevated privileges goes through a server action, never through the client directly.
2. **`use server` is a Hard Boundary**
   Any code touching the database securely or executing privileged admin operations **must** be inside a Server Action (marked with `"use server"`).
   - Client components (`"use client"`) **cannot** import direct database logic. They must call Server Actions.
   - Server components can call these functions directly.
   - Next.js Server Actions automatically serialize inputs and outputs.
3. **`audit_logs` is readable only by users with `system.admin`
   permission** — enforced at two levels together: database RLS, and the
   `/audit-logs` route guard in the UI. Any future change must preserve
   protection at both levels, not just one.
5. **`currencies.code` cannot be changed after creation** — enforced at
   the DB level via a dedicated migration that rejects any `UPDATE` that
   changes this field (to protect FK integrity).
6. **`.env` is never committed to Git** — there was a prior security
   incident that has since been resolved; it must not happen again.

## Documentation drift note

The API routes and file routing follow the Next.js App Router structure in `src/app/`. Make sure any structural documentation stays in sync with Next.js conventions.


## Supplier ledger UI boundary
- Supplier balances are read from `supplier_balances`; supplier statements are read from `supplier_statement`.
- Supplier opening balances and payments must use `src/app/actions/suppliers.ts`, which delegates to idempotent database RPCs.
- The browser does not write `supplier_transactions` directly.
- Supplier CRUD mutations also use the Server Action boundary; database RLS remains the authorization backstop.

## Customer ledger boundary
- Customer balances are derived from the customer ledger/read models; direct arbitrary balance edits are not an application mutation path.
- Customer opening balances and payments use `src/app/actions/customers.ts` and protected database RPCs.
- The browser does not write `debt_transactions` directly.
- `customer_statement` is the authoritative statement read model for customer ledger UI/export consumers.

## Statement read-model invariant
- `customer_statement` and `supplier_statement` must return exactly one row per underlying ledger transaction.
- Running balances are computed with PostgreSQL window functions ordered by `transaction_date`, `created_at`, and `id`.
- Avoid self-JOIN or other row-multiplying approaches for running-balance calculation.
- The application must consume the read models as-is rather than reconstructing running balances with client-side joins.
- Migration `20260915000000_fix_customer_statement_read_model.sql` records the customer read-model correction and has been applied to the live database.

## Current delivery checkpoint — 2026-09-15
- Phase 2 inventory core: closed.
- Phase 3 supplier ledger: UI + DB foundation implemented; final acceptance remains.
- Phase 4 customer ledger: closed; statement read model subsequently hardened to remove duplication/inflated-balance risk.
- Phase 5 reports & UX: next implementation phase.
