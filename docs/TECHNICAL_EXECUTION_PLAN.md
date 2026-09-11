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
