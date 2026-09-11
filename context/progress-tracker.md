# Progress Tracker — Inventory Management

> This is the one file that should keep changing. Update it after every
> meaningful work session — don't let it freeze while the code moves on.

## Last known-good reference point

Latest migration recorded in the repo:
`20260605101000_admin_profile_wrappers.sql` (June 5, 2026).

## Completed (confirmed directly from the code)

- 13 full pages under `_authenticated/`: dashboard, items, categories,
  units, suppliers, invoices (purchase), movements, customers, debts,
  users, permission-groups, audit-logs, reports, settings.
- A fine-grained RBAC system at the individual-permission level
  (`permissions`, `permission_groups`, `permission_group_items`,
  `user_permission_groups`, `user_permissions`) — not fixed roles only.
- A multi-unit system with conversion factors, built into purchase
  invoices.
- A multi-currency debt system (`currencies`, `exchange_rates`,
  `customer_balances`, `debt_transactions`).
- An audit trail (`audit_logs`) restricted to `system.admin` at both the
  RLS and route levels together.
- Built-in Excel and PDF export (`src/lib/excel.ts`, `src/lib/pdf.ts`).
- Full Arabic/English bilingual RTL/LTR support (Cairo/Inter fonts,
  custom sidebar).
- An SSR-safe session fix for authentication.
- Prior fixes: duplicate form submissions, conflicting RLS policies,
  trigger stack-overflow issues.
- A prior security incident (`.env` committed publicly) — resolved.
- `currencies.code` is now immutable after creation (DB-level).

## Open Questions — real gaps found during this audit, not invented

- **Profile avatar upload with WebP compression** was mentioned in
  earlier notes, but no trace of it was found in this code snapshot (no
  `webp`, no `storage.from` anywhere in `src/`). Confirm whether it lives
  on another branch or was removed later.
- **Documentation drift:** `/audit-logs` and `/permission-groups` exist
  in the code but are missing from `docs/ROUTES.md`.
- **Package manager conflict:** earlier notes mention Bun, but the file
  actually committed in this snapshot is `package-lock.json` (npm). This
  needs a single resolution to avoid lockfile conflicts between
  contributors/agents.
- **No prior progress-tracking file existed** despite substantial
  existing documentation in `docs/` (12 files) — this file is the actual
  starting point for live tracking.

## Next — Migration to Next.js

Full plan: `context/specs/00-migration-to-nextjs.md` (7 phases, 0–6).
Branch: `migration/nextjs`.

| Phase | Description | Status |
| --- | --- | --- |
| **Phase 0** | Set up Next.js alongside the current app | ✅ **Completed** (2026-09-11) |
| Phase 1 | Supabase SSR layer (`@supabase/ssr` + `middleware.ts`) | ❌ Not started |
| Phase 2 | Root layout and design system | ❌ Not started |
| Phase 3 | Auth pages and authenticated shell | ❌ Not started |
| Phase 4 | Migrate all 14 pages | ❌ Not started |
| Phase 5 | Server functions → Server Actions | ❌ Not started |
| Phase 6 | Final cutover and cleanup | ❌ Not started |

### Phase 0 details

- Installed: `next@16.3.4`, `@tailwindcss/postcss@4.3.3`, `postcss@8.5.28`.
- Created: `next.config.ts`, `postcss.config.mjs`, `tsconfig.next.json`,
  `app/layout.tsx`, `app/page.tsx`.
- Scripts: `dev:next` (port 3001, Turbopack), `build:next`.
- Fix: Next.js 16 auto-generates `AGENTS.md` — disabled via
  `agentRules: false` in `next.config.ts`.
- Verified: `npm run dev:next` works, `npm run build:next` succeeds,
  `npm run build` (Vite) is completely unaffected.
