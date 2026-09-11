"use server";

import { createClient } from "@/lib/supabase/server";

export async function adjustStock(input: {
  operationId: string;
  itemId: string;
  quantityDelta: number;
  unitPriceLocal?: number;
  movementDate: string;
  notes?: string;
}) {
  const supabase = await createClient();

  const { data: { user }, error: authError } = await supabase.auth.getUser();
  if (authError || !user) return { ok: false, error: "Authentication required" };

  const { data, error } = await (supabase as any).rpc("adjust_stock", {
    _operation_id: input.operationId,
    _item_id: input.itemId,
    _quantity_delta: input.quantityDelta,
    _unit_price_local: input.unitPriceLocal ?? 0,
    _movement_date: input.movementDate,
    _notes: input.notes ?? null,
  });

  if (error) return { ok: false, error: error.message };
  return { ok: true, movementId: data };
}
