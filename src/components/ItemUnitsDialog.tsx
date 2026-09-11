/**
 * ItemUnitsDialog
 * ───────────────
 * Dialog لإدارة وحدات الصنف المتعددة:
 * - إضافة / تعديل / حذف وحدة
 * - تحديد الوحدة الأساسية (factor = 1)
 * - تحديد الوحدة الافتراضية للشراء
 */
"use client";

import { useQuery, useQueryClient } from "@tanstack/react-query";
import { createClient } from "@/lib/supabase/client";

const supabase = createClient();
import { useI18n } from "@/lib/i18n";
import { toast } from "sonner";
import { cn } from "@/lib/utils";
import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Layers, Plus, Pencil, Trash2, Star, ShoppingCart, Check } from "lucide-react";
import { ConfirmDelete } from "@/components/ConfirmDelete";
import { fmtNum } from "@/lib/format";

// ─── types ────────────────────────────────────────────────────────────────────
interface ItemUnit {
  id: string;
  item_id: string;
  unit_id: string;
  conversion_factor: number;
  is_base_unit: boolean;
  is_purchase_default: boolean;
  last_purchase_price_local?: number;
}

// ─── Main Dialog ──────────────────────────────────────────────────────────────
export function ItemUnitsDialog({
  item,
  canManage,
}: {
  item: any;
  canManage: boolean;
}) {
  const { t, locale } = useI18n();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [editingUnit, setEditingUnit] = useState<ItemUnit | null>(null);

  const { data: units = [] } = useQuery({
    queryKey: ["units"],
    queryFn: async () => (await supabase.from("units").select("*")).data ?? [],
  });

  const { data: itemUnits = [], refetch } = useQuery({
    queryKey: ["item_units", item.id],
    queryFn: async () =>
      (
        await supabase
          .from("item_units")
          .select("*")
          .eq("item_id", item.id)
          .order("is_base_unit", { ascending: false })
          .order("conversion_factor")
      ).data ?? [],
    enabled: open,
  });

  const invalidate = () => {
    refetch();
    qc.invalidateQueries({ queryKey: ["item_units"] });
  };

  const unitName = (uid: string) => {
    const u = (units as any[]).find((x) => x.id === uid);
    return u?.[locale === "ar" ? "name_ar" : "name_en"] ?? uid;
  };

  const handleSetBase = async (iu: ItemUnit) => {
    const { error } = await supabase
      .from("item_units")
      .update({ is_base_unit: true })
      .eq("id", iu.id);
    if (error) toast.error(error.message);
    else invalidate();
  };

  const handleSetDefault = async (iu: ItemUnit) => {
    const { error } = await supabase
      .from("item_units")
      .update({ is_purchase_default: true })
      .eq("id", iu.id);
    if (error) toast.error(error.message);
    else invalidate();
  };

  const handleDelete = async (iu: ItemUnit) => {
    if (iu.is_base_unit) {
      toast.error(t("cannot_delete_base_unit"));
      return;
    }
    const { error } = await supabase.from("item_units").delete().eq("id", iu.id);
    if (error) toast.error(error.message);
    else invalidate();
  };

  // الوحدات الموجودة مسبقاً للـ item
  const usedUnitIds = (itemUnits as ItemUnit[]).map((iu) => iu.unit_id);
  // الوحدات المتاحة للإضافة (استبعاد الموجودة — إلا عند التعديل)
  const availableUnits = (units as any[]).filter(
    (u) => !usedUnitIds.includes(u.id) || editingUnit?.unit_id === u.id,
  );

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost" size="icon" title={t("item_units")}>
          <Layers className="h-4 w-4" />
        </Button>
      </DialogTrigger>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Layers className="h-4 w-4" />
            {t("item_units")} — {item.name_ar}
          </DialogTitle>
        </DialogHeader>

        {/* قائمة الوحدات */}
        <div className="space-y-2 max-h-72 overflow-y-auto">
          {(itemUnits as ItemUnit[]).length === 0 ? (
            <p className="text-center text-sm text-muted-foreground py-6">{t("no_units")}</p>
          ) : (
            (itemUnits as ItemUnit[]).map((iu) => (
              <div
                key={iu.id}
                className={cn(
                  "flex items-center gap-3 rounded-lg border px-3 py-2.5",
                  iu.is_base_unit ? "border-primary/30 bg-primary/5" : "bg-muted/30",
                )}
              >
                {/* اسم الوحدة + معامل التحويل */}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="font-medium text-sm">{unitName(iu.unit_id)}</span>
                    {iu.is_base_unit && (
                      <Badge variant="outline" className="text-[10px] px-1.5 py-0 border-primary/50 text-primary gap-1">
                        <Star className="h-2.5 w-2.5" />
                        {t("base_unit")}
                      </Badge>
                    )}
                    {iu.is_purchase_default && (
                      <Badge variant="outline" className="text-[10px] px-1.5 py-0 border-blue-500/50 text-blue-600 gap-1">
                        <ShoppingCart className="h-2.5 w-2.5" />
                        {t("purchase_default")}
                      </Badge>
                    )}
                  </div>
                  <p className="text-xs text-muted-foreground mt-0.5">
                    {iu.is_base_unit
                      ? t("base_unit_desc")
                      : `1 ${unitName(iu.unit_id)} = ${fmtNum(iu.conversion_factor, 4)} ${unitName(
                          (itemUnits as ItemUnit[]).find((x) => x.is_base_unit)?.unit_id ?? "",
                        )}`}
                    {(iu.last_purchase_price_local || 0) > 0 &&
                      ` · ${t("last_price")}: ${fmtNum(iu.last_purchase_price_local || 0, 2)}`}
                  </p>
                </div>

                {/* Actions */}
                {canManage && (
                  <div className="flex items-center gap-1 shrink-0">
                    {!iu.is_base_unit && (
                      <Button
                        size="icon"
                        variant="ghost"
                        className="h-7 w-7"
                        title={t("set_base_unit")}
                        onClick={() => handleSetBase(iu)}
                      >
                        <Star className="h-3.5 w-3.5" />
                      </Button>
                    )}
                    {!iu.is_purchase_default && (
                      <Button
                        size="icon"
                        variant="ghost"
                        className="h-7 w-7"
                        title={t("set_purchase_default")}
                        onClick={() => handleSetDefault(iu)}
                      >
                        <ShoppingCart className="h-3.5 w-3.5" />
                      </Button>
                    )}
                    <Button
                      size="icon"
                      variant="ghost"
                      className="h-7 w-7"
                      title={t("edit")}
                      onClick={() => setEditingUnit(iu)}
                    >
                      <Pencil className="h-3.5 w-3.5" />
                    </Button>
                    {!iu.is_base_unit && (
                      <ConfirmDelete onConfirm={() => handleDelete(iu)} />
                    )}
                  </div>
                )}
              </div>
            ))
          )}
        </div>

        {/* فورم الإضافة / التعديل */}
        {canManage && (
          <ItemUnitForm
            itemId={item.id}
            availableUnits={availableUnits}
            baseUnit={(itemUnits as ItemUnit[]).find((x) => x.is_base_unit)}
            editing={editingUnit}
            onDone={() => { setEditingUnit(null); invalidate(); }}
            onCancel={() => setEditingUnit(null)}
            existingCount={(itemUnits as ItemUnit[]).length}
          />
        )}
      </DialogContent>
    </Dialog>
  );
}

// ─── ItemUnitForm ─────────────────────────────────────────────────────────────
function ItemUnitForm({
  itemId,
  availableUnits,
  baseUnit,
  editing,
  onDone,
  onCancel,
  existingCount,
}: {
  itemId: string;
  availableUnits: any[];
  baseUnit?: ItemUnit;
  editing: ItemUnit | null;
  onDone: () => void;
  onCancel: () => void;
  existingCount: number;
}) {
  const { t, locale } = useI18n();
  const [unit_id, setUnitId] = useState(editing?.unit_id ?? "");
  const [factor, setFactor] = useState<number>(editing?.conversion_factor ?? 1);
  const [isBase, setIsBase] = useState(editing?.is_base_unit ?? existingCount === 0);
  const [isPurchaseDefault, setIsPurchaseDefault] = useState(
    editing?.is_purchase_default ?? existingCount === 0,
  );
  const [saving, setSaving] = useState(false);

  // إعادة ضبط عند فتح editing جديد
  useState(() => {
    if (editing) {
      setUnitId(editing.unit_id);
      setFactor(editing.conversion_factor);
      setIsBase(editing.is_base_unit);
      setIsPurchaseDefault(editing.is_purchase_default);
    }
  });

  const { data: user } = useQuery({
    queryKey: ["auth-user"],
    queryFn: async () => (await supabase.auth.getUser()).data.user,
  });

  const handleSave = async () => {
    if (!unit_id) return;
    setSaving(true);
    const payload = {
      item_id: itemId,
      unit_id,
      conversion_factor: isBase ? 1 : factor,
      is_base_unit: isBase,
      is_purchase_default: isPurchaseDefault,
      created_by: user?.id,
    };

    let error;
    if (editing) {
      ({ error } = await supabase.from("item_units").update(payload).eq("id", editing.id));
    } else {
      ({ error } = await supabase.from("item_units").insert(payload));
    }

    setSaving(false);
    if (error) toast.error(error.message);
    else { toast.success(t("save_success")); onDone(); }
  };

  const unitName = (u: any) => u?.[locale === "ar" ? "name_ar" : "name_en"] ?? "";

  return (
    <div className="border-t pt-4 space-y-3">
      <p className="text-sm font-medium">
        {editing ? t("edit_unit") : t("add_unit")}
      </p>
      <div className="grid grid-cols-2 gap-3">
        {/* الوحدة */}
        <div className="space-y-1">
          <Label className="text-xs">{t("unit")}</Label>
          <Select
            value={unit_id}
            onValueChange={setUnitId}
            disabled={!!editing} // لا تغيّر الوحدة عند التعديل
          >
            <SelectTrigger>
              <SelectValue placeholder={t("select")} />
            </SelectTrigger>
            <SelectContent>
              {availableUnits.map((u) => (
                <SelectItem key={u.id} value={u.id}>
                  {unitName(u)}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        {/* معامل التحويل */}
        <div className="space-y-1">
          <Label className="text-xs">
            {t("conversion_factor")}
            {baseUnit && !isBase && (
              <span className="text-muted-foreground ms-1">
                (= كم {baseUnit ? "" : ""})
              </span>
            )}
          </Label>
          <Input
            type="number"
            min="0.000001"
            step="0.001"
            value={factor}
            disabled={isBase}
            onChange={(e) => setFactor(Number(e.target.value))}
          />
          {!isBase && baseUnit && unit_id && (
            <p className="text-[11px] text-muted-foreground">
              1 وحدة = {fmtNum(factor, 4)} {baseUnit ? "" : ""}
            </p>
          )}
        </div>
      </div>

      {/* خيارات */}
      <div className="flex flex-wrap gap-4">
        <label className="flex items-center gap-2 cursor-pointer text-sm">
          <button
            type="button"
            onClick={() => { setIsBase(!isBase); if (!isBase) setFactor(1); }}
            className={cn(
              "h-4 w-4 rounded border-2 flex items-center justify-center transition-colors",
              isBase ? "bg-primary border-primary" : "border-muted-foreground",
            )}
          >
            {isBase && <Check className="h-3 w-3 text-primary-foreground" />}
          </button>
          <Star className="h-3.5 w-3.5 text-primary" />
          {t("is_base_unit")}
        </label>

        <label className="flex items-center gap-2 cursor-pointer text-sm">
          <button
            type="button"
            onClick={() => setIsPurchaseDefault(!isPurchaseDefault)}
            className={cn(
              "h-4 w-4 rounded border-2 flex items-center justify-center transition-colors",
              isPurchaseDefault ? "bg-blue-500 border-blue-500" : "border-muted-foreground",
            )}
          >
            {isPurchaseDefault && <Check className="h-3 w-3 text-white" />}
          </button>
          <ShoppingCart className="h-3.5 w-3.5 text-blue-500" />
          {t("is_purchase_default")}
        </label>
      </div>

      <div className="flex gap-2 justify-end">
        {editing && (
          <Button variant="outline" size="sm" onClick={onCancel}>
            {t("cancel")}
          </Button>
        )}
        <Button size="sm" onClick={handleSave} disabled={!unit_id || saving}>
          <Plus className="h-3.5 w-3.5 me-1" />
          {editing ? t("save") : t("add_unit")}
        </Button>
      </div>
    </div>
  );
}
