# Technical Execution Plan — Inventory Management

Snapshot: 2026-09-11. Based on the GitHub repository and live Supabase database.

## 1. Current tables

20 core public tables: profiles, permissions, permission_groups, permission_group_items, user_permission_groups, user_permissions, currencies, exchange_rates, categories, units, items, item_units, item_images, suppliers, customers, purchase_invoices, purchase_invoice_items, stock_movements, debt_transactions, audit_logs.

Derived read models: item_stock and customer_balances.

## 2. Relationships

profiles is referenced by creator/updater/audit fields. Permission groups connect to permissions through permission_group_items; users connect to groups through user_permission_groups and direct permissions through user_permissions. Items connect to categories/units and item_units/item_images. Purchase invoices connect to suppliers/currencies and invoice items. Invoice items connect to items and item_units. Stock movements connect to items. Debt transactions connect to customers/currencies. Audit logs connect to profiles.

## 3. RLS

RLS is enabled across the application schema. Access is authenticated plus fine-grained permissions. Anonymous public-schema privileges have been revoked. Permission checks now use current_user_has_permission(permission), bound to auth.uid(). Audit logs require system.admin. Storage has avatar and item-image policies.

## 4. Functions / triggers

Important functions: has_permission, is_admin, current_user_has_permission, audit_log_row_change, audit_log_diff, set_audit_changed_by, admin_update_profile, admin_delete_user_data, handle_new_user, set_updated_at, ensure_single_base_unit, ensure_single_primary_image, on_invoice_item_change, prevent_currency_code_update, compute_debt_local.

## 5. Actual problems

P0 — Inventory integrity: historical item_stock mechanisms coexist with stock_movements, while on_invoice_item_change inserts a stock movement on invoice-item changes. Updating a posted line can therefore duplicate stock. This must be resolved before Phase 2 is complete.

P0 — Negative stock: the database does not yet prove one authoritative, transaction-level invariant covering every stock mutation.

P1 — Direct client mutations: some pages access Supabase directly. This is protected by RLS but conflicts with the preferred architecture for business mutations. Purchase posting, voiding, stock adjustments, debt mutations, and permission administration should move behind server-side business operations.

P1 — Caller-supplied actorId: users.ts accepts actorId from action input. Authorization and audit identity must come from the authenticated server session.

P1 — Service-role boundary: every Server Action using service_role must authenticate and authorize the current user before bypassing RLS.

P1 — Audit actor is best-effort: setAuditChangedBy currently catches failures. Critical audited mutations should fail atomically if actor attribution cannot be established.

P2 — Documentation drift: database/read-model inventory should be kept authoritative.

## 6. Keep

Single company/branch/warehouse scope; fine-grained RBAC; Supabase Auth/SSR/RLS; multi-unit items; multi-currency balances; stock ledger; latest purchase price; posted/voided purchases; audit logs; images; existing design system and exports.

## 7. Modify

Make stock_movements the single authoritative inventory ledger. Make purchase posting and voiding atomic. Enforce no-negative-stock in the database. Make latest-purchase-price updates transactional. Move business mutations behind authorized Server Actions. Make audit actor attribution deterministic. Keep RLS and session-bound permission checks.

Do not add sales invoices, full accounting, multi-company/branch/warehouse, barcode/QR, batches, serials, expiry, returns, or cash/bank accounting.

## 8. Required migrations

No new business migration is required for this documentation step. Planned Phase 2 migrations: unify stock mutation paths, retire competing item_stock triggers if confirmed redundant, enforce no-negative-stock, support atomic posting/voiding, add required constraints/indexes, and strengthen ledger integrity.

## 9. Server Actions required

Purchases: postPurchase, voidPurchase, getPurchase, listPurchases.
Inventory: adjustStock, stock-count workflow, getStockMovement, getCurrentStock.
Customers: create/update customer, debit, payment, statement.
Suppliers: create/update supplier, settlement/payment if needed, statement.
Administration: user and permission/group management.

All mutation actions must derive the actor from the authenticated session.

## 10. Business invariants

1. No negative stock.
2. A posted purchase changes stock exactly once.
3. Voiding reverses exactly the posted effect once.
4. Posted purchases cannot silently create duplicate movements through edits.
5. Quantity and conversion factor are positive.
6. Purchase unit belongs to the item.
7. Latest purchase price updates atomically.
8. Historical invoice exchange-rate/price snapshots never change.
9. Customer/supplier balances come from ledger transactions, not arbitrary balance edits.
10. Audit actor is the actual authenticated actor.
11. Audit logs are not writable by normal users.
12. Permission checks use the current session.
13. Service-role credentials never reach the browser.
14. Void preserves history.
15. Financial and quantity calculations use PostgreSQL numeric precision for authoritative values.
16. Multi-row business mutations are atomic.

## 11. Tests required

Security: anonymous denial, permission denial, arbitrary-user helper denial, profile authorization, forged actor prevention, service-role non-exposure, storage path restrictions.

Inventory: exactly-once purchase posting, posted-line edit safety, void reversal, negative-stock rejection, concurrent mutation safety, unit conversion, last-purchase-price correctness.

Ledger: opening balance, debit/credit, payment, reversal, currency snapshot.

Authorization: every protected mutation must succeed only with the required permission; UI hiding is never considered sufficient security.

## 12. Execution order

Phase 1: finish RLS/Storage/Auth/GraphQL/secret review and verify.
Phase 2: map every stock mutation path; select stock_movements as source of truth; remove competing paths; implement atomic stock transaction; enforce no-negative-stock; implement posting/voiding; verify costing; add integration/concurrency tests.
Phase 3: harden purchasing and supplier ledger.
Phase 4: customer ledger.
Phase 5: reports and UX.

## Immediate next task

Before changing inventory schema, trace every INSERT/UPDATE/DELETE path affecting purchase_invoice_items, stock_movements, and item_stock in both migrations and application code. Then implement the smallest corrective migration that makes inventory behavior deterministic.

## Inventory mutation trace — 2026-09-11

Live trigger inspection confirms the active purchase-item stock path is narrower than the historical migrations suggest:

- purchase_invoice_items has trg_invoice_item_stock — AFTER INSERT -> on_invoice_item_change().
- purchase_invoice_items has trg_invoice_item_stock_del — BEFORE DELETE -> on_invoice_item_delete().
- There is no active UPDATE trigger on purchase_invoice_items for stock mutation.
- purchase_invoices has only audit + updated_at triggers in the live snapshot.
- stock_movements has audit logging only in the live snapshot.

The application invoice editor currently performs an invoice UPDATE, then deletes all existing invoice lines and inserts the replacement lines. Because the delete and re-insert fire stock triggers, editing an existing invoice can mutate stock even without an UPDATE trigger. This confirms the P0 integrity issue and makes the editor's current save strategy unsafe for posted invoices.

The live stock_movements table currently contains 4 rows at audit time; no destructive data migration was performed during this trace.

Decision: do not patch this with another trigger. Phase 2 should first introduce an explicit atomic purchase-posting/voiding transaction and then retire direct line-level stock side effects. The purchase editor must not be allowed to use delete/reinsert as a way to alter posted inventory.

## Phase 2 implementation checkpoint — 2026-09-11

Implemented the first purchase-lifecycle foundation in Supabase:

- Added `purchase_invoices.status` with only `posted` and `voided`; existing invoices default to `posted`.
- Added `voided_at` and `voided_by`.
- Added positive/non-negative checks for purchase quantities and monetary line values.
- Added `purchase_void` as a stock movement type.
- Removed the legacy invoice-line DELETE stock trigger.
- Added immutability enforcement for posted/voided invoices and all invoice lines.
- Added `void_purchase_invoice(uuid)`, which locks the invoice, checks the authenticated session permission, inserts reversal stock movements atomically, marks the invoice voided, and recomputes latest purchase price for affected items.
- Verified the migration applied successfully and the authenticated role can execute the void function.

Migrations:
- `20260911164500_purchase_lifecycle_immutable_posted.sql`
- `20260911165000_fix_purchase_immutability_trigger.sql`

Important: the application invoice editor still needs to be migrated to the new server-side/transactional workflow before users should edit existing invoices. The database now correctly rejects the old delete/reinsert editing behavior instead of silently mutating stock.

## Phase 2 application checkpoint — 2026-09-11

- Added `src/app/actions/purchases.ts` with authenticated `voidPurchase()` Server Action; it delegates the mutation to the DB transaction and does not accept an actor ID.
- Updated the invoices UI so posted invoices no longer expose the old edit/delete workflow; the destructive action is now a localized Void action.
- Added `ConfirmAction` for non-delete destructive confirmations and added Arabic/English void translations.
- Hardened the DB lifecycle further: direct posted-invoice DELETE is blocked, direct posted->voided UPDATE is blocked unless it occurs inside `void_purchase_invoice()`, and invoice-line DELETE/UPDATE remains blocked.
- Applied `20260911170500_harden_purchase_void_transition.sql` and `20260911171000_block_purchase_invoice_delete.sql` successfully.

Remaining before calling purchasing safe: replace the old invoice CREATE path (client-side invoice + line inserts) with a single authenticated Server Action/transaction, then implement and test the no-negative-stock invariant and exactly-once posting behavior.

## Phase 2 inventory serialization checkpoint — 2026-09-11

- Hardened `on_invoice_item_change()` to require a posted invoice and positive quantity/conversion, and added a transaction-scoped advisory lock per item before creating the purchase movement.
- Hardened `void_purchase_invoice()` to lock the invoice and every affected item, validate that reversal will not produce negative stock, and use the same per-item serialization key.
- Applied `20260911173000_inventory_item_serialization.sql` successfully.
- Important scope note: purchases are positive movements, so this step does not by itself implement the complete no-negative-stock invariant for outbound/adjustment movements. Every future negative-stock movement must use the same item lock and check before INSERT.
- No test purchase or void was created against live business data during this checkpoint.

## Phase 2 inventory mutation boundary — 2026-09-11

- Added `adjust_stock(...)` as the controlled stock-adjustment mutation: authenticated, `items.manage` authorized, per-item transaction lock, negative-result rejection, and idempotency by operation UUID.
- Added `src/app/actions/inventory.ts` as the Server Action boundary for adjustments.
- Stock ledger remains append-only from the application perspective; direct client writes are not part of the supported mutation path.
- Verified `adjust_stock` exists as `SECURITY DEFINER` with `authenticated` EXECUTE permission and the database remains RLS-enabled for `stock_movements`.
- No live adjustment was created.

Next: audit every remaining stock-changing trigger/function and consolidate opening-balance handling, then add isolated integration/concurrency tests before declaring Phase 2 complete.

## Final Phase 2 audit checkpoint — 2026-09-11

- Audited repository references and database triggers around `stock_movements`.
- Confirmed purchase item stock creation is trigger-driven and purchase/void lifecycle guards are active.
- Found and fixed a privilege-layer issue: an older migration had table-level INSERT/DELETE grants that survived policy removal. Migration `20260911180500_revoke_direct_stock_ledger_writes.sql` now revokes all direct mutation privileges from `anon`/`authenticated` and leaves authenticated SELECT only.
- Verified final table privileges: anonymous INSERT = false; authenticated INSERT/UPDATE/DELETE = false; authenticated SELECT = true.
- No live stock adjustment or purchase was created during this audit.

Phase 2 is now ready for isolated integration/concurrency testing. Do not add new inventory mutation paths without routing them through a transaction boundary with the same item serialization invariant.
