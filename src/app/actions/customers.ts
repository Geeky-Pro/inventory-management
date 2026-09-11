"use server";

import { createClient } from "@/lib/supabase/server";

export async function addCustomerOpeningBalance(input: {
  operationId: string; customerId: string; amountLocal: number; currencyCode: string;
  exchangeRate: number; transactionDate: string; notes?: string;
}) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("add_customer_opening_balance", {
    _operation_id: input.operationId, _customer_id: input.customerId, _amount_local: input.amountLocal,
    _currency_code: input.currencyCode, _exchange_rate: input.exchangeRate,
    _transaction_date: input.transactionDate, _notes: input.notes ?? null,
  });
  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data };
}

export async function recordCustomerPayment(input: {
  operationId: string; customerId: string; amountLocal: number; currencyCode: string;
  exchangeRate: number; transactionDate: string; paymentMethod: string; notes?: string;
}) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("record_customer_payment", {
    _operation_id: input.operationId, _customer_id: input.customerId, _amount_local: input.amountLocal,
    _currency_code: input.currencyCode, _exchange_rate: input.exchangeRate,
    _transaction_date: input.transactionDate, _payment_method: input.paymentMethod, _notes: input.notes ?? null,
  });
  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data };
}
