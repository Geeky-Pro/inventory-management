# Architecture — Inventory Management

## Stack (from the actual `package.json`)

| Layer | Technology |
|---|---|
| Framework | React 19.2 + TanStack Start 1.167 (SSR) + TanStack Router 1.168 |
| Bundler | Vite 7.3 + TypeScript 5.8 |
| DB / Auth / Storage | Supabase (Postgres + RLS + Auth) — `@supabase/supabase-js` 2.106 |
| UI | Tailwind CSS v4 (CSS-first config) + shadcn/ui + Radix primitives |
| Forms | react-hook-form + zod |
| Export | jspdf / jspdf-autotable (PDF), xlsx (Excel) |
| Tests | vitest |
| Lint/Format | ESLint 9 (flat config) + typescript-eslint + Prettier |
| Package manager | **npm** — `package-lock.json` is the file actually committed in this snapshot. ⚠️ Earlier notes mentioned Bun — if it's used locally, confirm which one is the official source of truth to avoid lockfile conflicts. |

## File structure

- `src/start.ts` — TanStack Start setup and middleware registration
  (`auth-attacher`, error middleware).
- `src/server.ts` — the general SSR entry point (fetch handler) for edge
  environments.
- `src/router.tsx` / `src/routeTree.gen.ts` — router configuration
  (**auto-generated — never edited by hand**).
- `src/routes/` — file-based routing. `__root.tsx` for the root layout,
  `_authenticated.tsx` for the guard + mounting `AppSidebar`/`AppHeader`.
- `src/components/` — `AppHeader`, `AppSidebar`, `DataTable`,
  `ConfirmDelete`, `PageHeader` at the top level, and
  `src/components/ui/` for shadcn/Radix primitives.
- `src/lib/api/*.functions.ts` — TanStack server functions (e.g.
  `users.functions.ts`, `admin.ts`).
- `src/lib/i18n.tsx`, `src/lib/permissions.tsx`, `src/lib/excel.ts`,
  `src/lib/pdf.ts` — shared logic.
- `src/integrations/supabase/` — `client.ts` (publishable client) vs.
  `client.server.ts` (admin/service-role client) + `auth-attacher.ts` +
  the generated `types.ts` from the schema.
- `supabase/migrations/` — 18 SQL files so far (latest: 2026-06-05).

## Database (20 tables actually, per `public_schema_tables.tsv`)

`audit_logs`, `categories`, `currencies`, `customer_balances`, `customers`,
`debt_transactions`, `exchange_rates`, `item_stock`, `items`,
`permission_group_items`, `permission_groups`, `permissions`, `profiles`,
`purchase_invoice_items`, `purchase_invoices`, `stock_movements`,
`suppliers`, `units`, `user_permission_groups`, `user_permissions`.

## Invariants — rules that must never be broken

1. **`SUPABASE_SERVICE_ROLE_KEY` must never be exposed to the client.**
   Only `client.server.ts` uses it. Anything that needs elevated
   privileges goes through a server function, never through the client
   directly.
2. **`use server` is a Hard Boundary**
   Any code touching the database securely or executing privileged admin operations **must** be inside a Server Action (marked with `"use server"`).
   - Client components (`"use client"`) **cannot** import direct database logic. They must call Server Actions.
   - Server components can call these functions directly.
   - Next.js Server Actions automatically serialize inputs and outputs.
3. **`src/routeTree.gen.ts` is auto-generated — never edited by hand.**
4. **`audit_logs` is readable only by users with `system.admin`
   permission** — enforced at two levels together: database RLS, and the
   `/audit-logs` route guard in the UI. Any future change must preserve
   protection at both levels, not just one.
5. **`currencies.code` cannot be changed after creation** — enforced at
   the DB level via a dedicated migration that rejects any `UPDATE` that
   changes this field (to protect FK integrity).
6. **`.env` is never committed to Git** — there was a prior security
   incident that has since been resolved; it must not happen again.

## Documentation drift note

The `/audit-logs` and `/permission-groups` routes actually exist under
`src/routes/_authenticated/` but are not mentioned in `docs/ROUTES.md` —
that file should be updated at the next opportunity (the docs agent
mentioned in `.github/AGENTS.md` owns this).
