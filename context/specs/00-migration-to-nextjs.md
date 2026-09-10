# Spec 00 — Migrate the project to Next.js

## Goal

Fully migrate from (React 19 + TanStack Start/Router + Vite) to Next.js
(App Router), **without breaking anything that currently works**, by
running both frameworks side by side in the same repository until full
parity is proven, then cutting over all at once only at the very end.

## Why this is safe (Design)

`src/routes/` (current routing) and `app/` (Next.js routing) are
**completely different directories** — there is no collision between
them. That means a full Next.js app can be built inside the same
repository, on a separate branch, while the existing app keeps running
completely untouched for the entire migration. No file under
`src/routes/`, `vite.config.ts`, `src/start.ts`, or `src/server.ts` gets
deleted until the very last phase, and only after every page has been
confirmed working.

**A deliberate strategic decision:** keep `@tanstack/react-query` for
data fetching inside migrated pages (as `'use client'` components),
instead of rewriting everything into full Server Components/Server
Actions style. This shrinks the blast radius to just the routing layer
and server functions — which is exactly what "without breaking anything"
requires.

## Real risks found in the code (not hypothetical)

1. **Routing/navigation** — every use of `useNavigate`, `Link` from
   `@tanstack/react-router`, `useParams`, `useSearch` (with zod
   validation) needs a Next.js equivalent. This touches almost every
   page.
2. **SSR session** — there was already a documented fix for this exact
   problem under TanStack Start; it needs to be solved again, the
   Next.js way (`@supabase/ssr` + `middleware.ts`), with extreme care,
   before any other page is touched.
3. **Environment variables** — `VITE_SUPABASE_*` doesn't work in
   Next.js; client-exposed variables must become
   `NEXT_PUBLIC_SUPABASE_*`.
4. **Server functions** — `src/lib/api/*.functions.ts` (TanStack
   `createServerFn`) become Server Actions (`'use server'`) or Route
   Handlers.
5. **The `*.server.ts` naming rule** (Invariant #2 in `architecture.md`)
   loses its meaning in Next.js — it gets replaced by the `'use server'`
   directive. Update `architecture.md` once this phase is reached.
6. **Tailwind v4 + Next.js** needs `@tailwindcss/postcss` instead of
   `@tailwindcss/vite` — a different setup, not the same file.

---

## Implementation — phases in order (each phase is its own unit of work)

### Phase 0 — Set up Next.js alongside the current app

- New branch: `migration/nextjs`.
- `npm install next@latest` + `next.config.ts` + an empty `app/` folder.
- New scripts that don't touch the old ones: `dev:next`, `build:next`
  (the existing `dev`/`build` keep running Vite exactly as they are).
- Set up Tailwind v4 for Next via `@tailwindcss/postcss`, and import the
  exact same `src/styles.css` in `app/layout.tsx` (the same file, not a
  copy).
- **Verification:** `npm run dev:next` shows a test page with correct
  Cairo/Inter fonts and correct OKLCH colors. `npm run dev` (the old one)
  is completely unaffected.

### Phase 1 — Supabase layer for SSR (highest risk)

- Install `@supabase/ssr`.
- `lib/supabase/client.ts` (browser) and `lib/supabase/server.ts`
  (server, via `cookies()` from `next/headers`) — new files, the
  existing `src/integrations/supabase/*` files are not modified.
- Add `NEXT_PUBLIC_SUPABASE_URL` and
  `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` to the env file (alongside the
  old `VITE_*` variables, not replacing them yet).
- Root-level `middleware.ts`: refreshes session cookies + guards
  authenticated routes.
- **Verification:** log in through the old (Vite) app, then open a test
  page on `dev:next` and confirm it sees the same session (`getUser()`
  succeeds). This is the single most important verification point in
  the whole migration — don't move on until you're fully confident it
  works.

### Phase 2 — Root layout and design system

- `app/layout.tsx` = the equivalent of `src/routes/__root.tsx`.
- Dynamic `dir`/`lang` logic (Arabic RTL / English LTR) is read from a
  cookie on the server side, to avoid a flash of the wrong direction
  (FOUC).
- Copy `src/components/ui/*` as-is (pure React components, no changes
  expected).
- **Verification:** a test page renders `AppSidebar`/`AppHeader`
  correctly in both RTL and LTR.

### Phase 3 — Auth pages and the authenticated shell

- `app/login/page.tsx`, `app/signup/page.tsx` (react-hook-form + zod
  forms copy over with no logic changes).
- `app/(authenticated)/layout.tsx` = the equivalent of
  `_authenticated.tsx`.
- **Verification:** log in → empty dashboard shell → hard refresh (F5)
  and the session persists. (This is exactly the bug that was already
  fixed once under TanStack Start — it must not be reintroduced here.)

### Phase 4 — Migrate pages (lowest risk to highest)

Suggested order based on each page's actual complexity:

1. `dashboard`, `settings` (simple display)
2. `categories`, `units` (simple CRUD)
3. `suppliers`, `customers`
4. `items` (has a multi-image gallery with touch/context-menu
   interactions — test the interaction carefully)
5. `movements`, `reports` (Excel/PDF export — framework-independent
   logic, ports directly)
6. `invoices` (multi-unit + conversion factors — the most complex
   business logic)
7. `debts` (multi-currency — calculation accuracy is critical, test the
   numbers, not just the layout)
8. `users`, `permission-groups` (security-sensitive)
9. `audit-logs` (deliberately last — least used, most sensitive)

For each page: replace only the routing hooks (`useNavigate` →
`useRouter`/`redirect`, `Link` → `next/link`, `useSearch` →
`useSearchParams`), and keep the data-fetching logic through TanStack
Query exactly as it is, inside a `'use client'` component.

### Phase 5 — Server functions

- Each file in `src/lib/api/*.functions.ts` → an equivalent Server
  Action with the same input/output signature, to minimize changes in
  the calling code.
- Update Invariant #2 in `architecture.md`: the rule is now `'use
  server'`, not `*.server.ts`.

### Phase 6 — Final cutover

- Remove the `VITE_*` variables once every page is confirmed.
- Point the `dev`/`build`/`start` scripts to Next.js.
- Delete: `vite.config.ts`, `src/start.ts`, `src/server.ts`,
  `src/router.tsx`, `src/routeTree.gen.ts`, `src/routes/`, and the
  packages `@tanstack/react-start` / `@tanstack/router-plugin` /
  `@tanstack/react-router` (keep `@tanstack/react-query` — a completely
  different package, still in use).
- Run the full `tests/integration/*.test.ts` suite.
- **Manually re-audit all six Invariants in `architecture.md`** —
  especially that `SUPABASE_SERVICE_ROLE_KEY` never leaks (the leak
  pattern differs slightly between Route Handlers and Server Actions —
  worth a dedicated check, not an assumption that it's "the same
  thing").
- Update `docs/ARCHITECTURE.md`, `docs/ROUTES.md`, and
  `context/architecture.md`.

## Dependencies

Phases are strictly sequential (0→1→2→3→4→5→6). Don't start a phase
before the previous one's verification has fully passed. After each
phase: update `context/progress-tracker.md` with its status (in
progress / completed) before moving to the next one — that's the actual
purpose of that file.

## Overall verification checklist (before considering the migration done)

- [ ] All 13 pages behave identically on Next.js.
- [ ] The session survives a page refresh (F5) on every authenticated
      page.
- [ ] RTL/LTR is correct on every page.
- [ ] `audit_logs` is still restricted to `system.admin` at both the RLS
      and route levels.
- [ ] `currencies.code` is still immutable (this is DB-level and
      unaffected by the migration, but confirm the new UI doesn't
      assume otherwise).
- [ ] Excel/PDF export works from the migrated pages.
- [ ] No remaining `VITE_*` references anywhere in the code after Phase
      6.
- [ ] `npm run lint` and `npm run test` both pass on the new branch.
