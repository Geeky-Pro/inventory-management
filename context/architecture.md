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
