# AI Workflow Rules — Inventory Management

This file complements the existing `.github/AGENTS.md` (which defines
routing between specialized agents: coordinator, arabic, planner,
frontend, backend, supabase, qa, docs). Check that first to know "who
executes", then apply the rules below for "how it gets executed".

## Before any implementation

- Any frontend/backend agent reads `context/architecture.md` and
  `context/code-standards.md` first. Any agent working on UI also reads
  `context/ui-context.md`.
- **The Supabase agent uses MCP only** as the source of truth for
  project/database data — it does not rely on local config files when
  MCP is available to answer directly (this rule already exists in
  `.github/AGENTS.md`; restated here because it affects architectural
  decisions).

## During implementation

- One unit of work at a time. Don't touch files outside the defined
  scope of that unit.
- Any change that touches an Invariant listed in
  `context/architecture.md` (e.g. `audit_logs` protection, or the
  `currencies.code` immutability rule) requires stopping and asking the
  project owner explicitly before proceeding — never assume the change
  is "a simple exception".
- No new UI primitives outside `src/components/ui/` unless explicitly
  requested.

## After every meaningful implementation

- **Update `context/progress-tracker.md` immediately** (this step was
  missing from the project's prior setup despite a large amount of
  existing documentation in `docs/`).
- If the implementation changed an architectural decision or a
  previously documented scope, update the relevant context file in the
  same session — not later.
- The docs agent (mentioned in `.github/AGENTS.md`) owns keeping
  `docs/*.md` matched to reality — if you notice drift (like an
  undocumented route), flag it explicitly instead of ignoring it.
