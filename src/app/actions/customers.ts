"use server";

import { createClient } from "@/lib/supabase/server";

export async function createCustomerTransaction(input: {
  customerId: string;
  transactionType: "debit" | "credit";
  amount: number;
  currencyCode: string;
  exchangeRate: number;
  transactionDate: string;
  invoiceRef?: string;
  notes?: string;
}) {
  const supabase = await createClient();
  const { data: { user }, error: authError } = await supabase.auth.getUser();
  if (authError || !user) return { ok: false, error: "Authentication required" };

  if (!Number.isFinite(input.amount) || input.amount <= 0) return { ok: false, error: "Amount must be positive" };
  if (!Number.isFinite(input.exchangeRate) || input.exchangeRate <= 0) return { ok: false, error: "Exchange rate must be positive" };

  const { data, error } = await supabase.from("debt_transactions").insert({
    customer_id: input.customerId,
    transaction_type: input.transactionType,
    amount: input.amount,
    currency_code: input.currencyCode,
    exchange_rate: input.exchangeRate,
    amount_local: input.amount * input.exchangeRate,
    transaction_date: input.transactionDate,
    invoice_ref: input.invoiceRef ?? null,
    notes: input.notes ?? null,
    created_by: user.id,
  }).select("id").single();

  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data.id };
}
