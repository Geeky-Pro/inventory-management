"use server";

import { createClient } from "@/lib/supabase/server";
import { z } from "zod";

const VoidPurchaseSchema = z.object({
  invoiceId: z.string().uuid(),
});

export async function voidPurchase(input: unknown) {
  const parsed = VoidPurchaseSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: "Invalid invoice id" };

  const supabase = await createClient();
  const { data: { user }, error: authError } = await supabase.auth.getUser();

  if (authError || !user) {
    return { ok: false, error: "Authentication required" };
  }

  const { error } = await (supabase as any).rpc("void_purchase_invoice", {
    _invoice_id: parsed.data.invoiceId,
  });

  if (error) return { ok: false, error: error.message };
  return { ok: true };
}
