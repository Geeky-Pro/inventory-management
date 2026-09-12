# UI Context — Inventory Management

## Fonts

- Arabic / RTL → **Cairo** (weights 400–800).
- English / LTR → **Inter** (weights 400–700).
- Determined automatically by the `dir` applied to `<html>` — don't force
  a different font manually inside an individual component.

## Color system — strict rule: OKLCH only

Every semantic color (`primary`, `secondary`, `muted`, `accent`,
`destructive`, `border`, `input`, `ring`, `sidebar-*`, `chart-1..5`) is
defined in `:root` and `.dark` inside `src/styles.css`, and wired through
`@theme inline` into Tailwind utilities (`bg-primary`, `text-primary`,
etc.).

**Explicit rule already stated in the code comments themselves:** any new
color is added as an `oklch()` value exclusively, with two values (light
in `:root`, dark in `.dark`), then registered in `@theme inline`. Raw
hex/rgb values inside components are not allowed.

The current theme is the **default shadcn theme** (no custom brand
identity/colors applied yet). [Needs clarification from the owner] whether
color customization is actually planned, or keeping the default is a
final decision.

## Radius

- One base value: `--radius: 0.625rem`.
- Every scale step (`sm` through `4xl`) is computed from this base — don't
  hardcode a radius value in a component; change the base variable only
  if a global change is needed.

## Dark mode

- Fully implemented via a `.dark` class at the root level — every
  `:root` variable has a `.dark` counterpart.

## Direction (RTL/LTR)

- The sidebar is purpose-built to support both RTL and LTR, with a
  dedicated backdrop for mobile.
- Any new layout must be tested in both directions before merging, not
  just the Arabic one.


## Supplier ledger UI
- `/suppliers` shows the derived supplier balance and exposes statement/navigation actions.
- `/suppliers/[id]` is the supplier statement page with debit, credit, running balance, opening balance, and payment operations.
- Opening balance and payment dialogs use the existing shadcn/Radix primitives and Arabic/English i18n.
- Supplier ledger mutations are never performed directly from the browser; they call Server Actions.
