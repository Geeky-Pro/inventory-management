# Agent Entry Point — Inventory Management

For routing between specialized agents (coordinator, arabic, planner,
frontend, backend, supabase, qa, docs), see `.github/AGENTS.md` first.

## Before any implementation or architectural decision

Read the six context files in this order:

1. `context/project-overview.md`
2. `context/architecture.md`
3. `context/ui-context.md`
4. `context/code-standards.md`
5. `context/ai-workflow-rules.md`
6. `context/progress-tracker.md`

## After every meaningful implementation change

Update `context/progress-tracker.md` immediately. If the implementation
changed an architectural decision or a previously documented standard,
update the relevant context file in the same session — not later.
