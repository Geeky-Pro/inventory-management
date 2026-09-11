# Project Overview — Inventory Management

## What this project is (extracted from the actual code)

An inventory and sales management system with a built-in accounting
component (multi-currency customer debts), with a fully bilingual
Arabic/English interface (RTL/LTR), built on React 19 + Next.js (App Router)
+ Supabase.

**Precise target audience (store size, retail vs. wholesale, expected
number of users):** [Needs clarification from the owner — not clear from
the code]

## Features actually built (from `src/app/(authenticated)/`)

- **Dashboard** — main landing page.
- **Items / Categories / Units** — item management, with a **multi-unit
  system with conversion factors** built into purchase invoices.
- **Suppliers / Purchase Invoices / Stock Movements** — the purchasing
  cycle and stock movement tracking.
- **Customers / Debts** — customer balances and **multi-currency** debts
  (tables `currencies`, `exchange_rates`, `customer_balances`,
  `debt_transactions`).
- **Users / Permission Groups** — a fine-grained permission system (RBAC)
  at the individual-permission level, not fixed roles only.
- **Audit Logs** — an audit trail fully restricted to `system.admin`
  users (hidden from everyone else at both the route and RLS level).
- **Reports** — reporting, with built-in **Excel and PDF export**
  (`src/lib/excel.ts`, `src/lib/pdf.ts`).
- **Settings** — general settings.

## Language and direction

- Arabic (RTL, Cairo font) / English (LTR, Inter font) — switches
  automatically based on the `dir` applied to `<html>`. Logic lives in
  `src/lib/i18n.tsx`.
- A custom sidebar supports both RTL and LTR, with a dedicated mobile
  backdrop.

## Out of Scope (for now)

Nothing in the code suggests any of the following exist. If any of these
are actually on the roadmap, state that explicitly before any agent
assumes otherwise:
- An online payment gateway.
- A separate native mobile app.
- Multi-warehouse/multi-branch support — current tables show no explicit
  branch-level isolation.

[Needs clarification from the owner] whether any of the above is actually
planned or permanently out of scope.
