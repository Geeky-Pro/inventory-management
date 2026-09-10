# Code Standards — Inventory Management

## TypeScript

- Avoid `any` wherever possible (documented in `docs/CONTRIBUTING.md`).
- A deliberate exception exists in `eslint.config.js`:
  `@typescript-eslint/no-unused-vars` is intentionally disabled — don't
  re-enable it without discussion, this is an existing decision, not an
  oversight.
- Importing the Next.js `server-only` package is forbidden — use a
  `*.server.ts` suffix or `@tanstack/react-start/server-only` instead
  (enforced as an ESLint error).

## Before any PR

- `npm run lint` must pass with no critical errors.
- `npm run format` (Prettier) on every changed file.
- `src/routeTree.gen.ts` is never edited by hand, ever.

## Shared components — use these before reinventing them

Any new CRUD page is built on top of these four first (check any existing
page in `src/routes/_authenticated/` as a reference):
- `DataTable` — a generic table with filtering and pagination.
- `ConfirmDelete` — a reusable delete-confirmation dialog.
- `PageHeader` — a unified page header (title + action buttons).
- `AppSidebar` / `AppHeader` — don't change navigation layout outside
  these two files.

## UI primitives layer

- `src/components/ui/` only, for low-level shadcn/Radix primitives
  (button, input, select, dialog, table, sidebar, etc.).
- No new low-level UI primitives outside this path unless explicitly
  requested — any new component of this kind must follow the existing
  theme and spacing conventions.

## Server functions

- Collected in `src/lib/api/*.functions.ts` (current naming pattern:
  `admin.ts`, `users.functions.ts`, `example.functions.ts`). Any new
  server logic follows the same location and naming — it doesn't get
  scattered inside UI components.

## Migrations

- A new, clearly timestamped SQL file in `supabase/migrations/`.
- Never edit a migration file after it has shipped to a shared
  environment — add a new file with the follow-up change instead.
- Document the change in `docs/DB_MIGRATIONS.md` when relevant.

## Package manager

- The file actually committed to the repo is `package-lock.json` (npm).
  If Bun is genuinely used locally, this needs to be resolved to one
  official source of truth, to avoid lockfile conflicts between
  contributors/agents.
