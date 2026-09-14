-- Fix customer statement read model to return one row per debt transaction.
-- Running balance is computed directly with a window function, matching supplier_statement.
create or replace view public.customer_statement as
select
  st.id,
  st.customer_id,
  st.transaction_date,
  st.created_at,
  st.transaction_type,
  st.amount,
  st.currency_code,
  st.exchange_rate,
  st.amount_local,
  st.reference_table,
  st.reference_id,
  st.invoice_ref,
  st.payment_method,
  st.notes,
  st.created_by,
  coalesce(
    sum(
      case
        when st.transaction_type = 'debit' then st.amount_local
        else -st.amount_local
      end
    ) over (
      partition by st.customer_id
      order by st.transaction_date, st.created_at, st.id
      rows between unbounded preceding and current row
    ),
    0::numeric
  ) as running_balance_local
from public.debt_transactions st;
