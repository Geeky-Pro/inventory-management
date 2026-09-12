"use server";

import { createClient } from "@/lib/supabase/server";

type SupplierInput = {
  name: string;
  phone?: string | null;
  notes?: string | null;
  defaultCurrency?: string | null;
  defaultPaymentType?: string | null;
};

export async function createSupplier(input: SupplierInput) {
  const supabase = await createClient();
  const { data: user } = await supabase.auth.getUser();
  if (!user.user) return { ok: false, error: "Authentication required" };
  if (!input.name.trim()) return { ok: false, error: "Supplier name is required" };
  const { data, error } = await supabase.from("suppliers").insert({
    name: input.name.trim(), phone: input.phone ?? null, notes: input.notes ?? null,
    default_currency: input.defaultCurrency ?? null, default_payment_type: input.defaultPaymentType ?? "cash",
    created_by: user.user.id,
  }).select("id").single();
  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data.id };
}

export async function updateSupplier(id: string, input: SupplierInput) {
  const supabase = await createClient();
  const { data: user } = await supabase.auth.getUser();
  if (!user.user) return { ok: false, error: "Authentication required" };
  if (!id || !input.name.trim()) return { ok: false, error: "Supplier name is required" };
  const { error } = await supabase.from("suppliers").update({
    name: input.name.trim(), phone: input.phone ?? null, notes: input.notes ?? null,
    default_currency: input.defaultCurrency ?? null, default_payment_type: input.defaultPaymentType ?? "cash",
    updated_by: user.user.id,
  }).eq("id", id);
  if (error) return { ok: false, error: error.message };
  return { ok: true };
}

export async function deleteSupplier(id: string) {
  const supabase = await createClient();
  const { data: user } = await supabase.auth.getUser();
  if (!user.user) return { ok: false, error: "Authentication required" };
  const { error } = await supabase.from("suppliers").delete().eq("id", id);
  if (error) return { ok: false, error: error.message };
  return { ok: true };
}

export async function addSupplierOpeningBalance(input: {
  operationId: string; supplierId: string; amountLocal: number; currencyCode: string;
  exchangeRate: number; transactionDate: string; notes?: string;
}) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("add_supplier_opening_balance", {
    _operation_id: input.operationId, _supplier_id: input.supplierId, _amount_local: input.amountLocal,
    _currency_code: input.currencyCode, _exchange_rate: input.exchangeRate,
    _transaction_date: input.transactionDate, _notes: input.notes ?? null,
  });
  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data };
}

export async function recordSupplierPayment(input: {
  operationId: string; supplierId: string; amountLocal: number; currencyCode: string;
  exchangeRate: number; transactionDate: string; paymentMethod: string; notes?: string;
}) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("pay_supplier", {
    _operation_id: input.operationId, _supplier_id: input.supplierId, _amount_local: input.amountLocal,
    _currency_code: input.currencyCode, _exchange_rate: input.exchangeRate,
    _transaction_date: input.transactionDate, _payment_method: input.paymentMethod, _notes: input.notes ?? null,
  });
  if (error) return { ok: false, error: error.message };
  return { ok: true, id: data };
}
