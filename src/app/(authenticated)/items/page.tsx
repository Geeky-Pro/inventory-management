"use client";

import { useQuery, useQueryClient } from "@tanstack/react-query";
import { createClient } from "@/lib/supabase/client";
import { PageHeader } from "@/components/PageHeader";
import { DataTable } from "@/components/DataTable";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { useI18n } from "@/lib/i18n";
import { usePermissions } from "@/lib/next/permissions";
import { ConfirmDelete } from "@/components/ConfirmDelete";
import { ItemUnitsDialog } from "@/components/ItemUnitsDialog";
import { exportToExcel, readExcelFile } from "@/lib/excel";
import { fmtNum } from "@/lib/format";
import {
  ContextMenu,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuSeparator,
  ContextMenuTrigger,
} from "@/components/ui/context-menu";
import {
  Plus,
  Pencil,
  Upload,
  Download,
  Images,
  Star,
  StarOff,
  Trash2,
  X,
  ImagePlus,
} from "lucide-react";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { toast } from "sonner";

// ─── helpers ─────────────────────────────────────────────────────────────────

const BUCKET = "item-images";

function getPublicUrl(supabase: any, path: string) {
  const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
  return data.publicUrl;
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function ItemsPage() {
  const { t, locale } = useI18n();
  const { can } = usePermissions();
  const qc = useQueryClient();
  const supabase = createClient();
  const [search, setSearch] = useState("");

  const { data: items = [] } = useQuery({
    queryKey: ["items"],
    queryFn: async () => (await supabase.from("items").select("*").order("name_ar")).data ?? [],
  });
  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: async () => (await supabase.from("categories").select("*")).data ?? [],
  });
  const { data: units = [] } = useQuery({
    queryKey: ["units"],
    queryFn: async () => (await supabase.from("units").select("*")).data ?? [],
  });
  const { data: stock = [] } = useQuery({
    queryKey: ["item_stock"],
    queryFn: async () =>
      (await supabase.from("stock_movements").select("item_id, quantity")).data ?? [],
  });
  // جلب الصورة الرئيسية لكل صنف دفعة واحدة
  const { data: primaryImages = [] } = useQuery({
    queryKey: ["item_primary_images"],
    queryFn: async () =>
      (await supabase.from("item_images").select("item_id, storage_path").eq("is_primary", true)).data ?? [],
  });
  // وحدات كل صنف (للعرض في الجدول)
  const { data: allItemUnits = [] } = useQuery({
    queryKey: ["item_units"],
    queryFn: async () =>
      (await supabase.from("item_units").select("*").order("is_base_unit", { ascending: false }).order("conversion_factor")).data ?? [],
  });

  const primaryMap = useMemo(() => {
    const m = new Map<string, string>();
    for (const img of primaryImages as any[]) m.set(img.item_id, img.storage_path);
    return m;
  }, [primaryImages]);

  const stockMap = useMemo(() => {
    const m = new Map<string, number>();
    for (const s of stock as any[]) m.set(s.item_id, (m.get(s.item_id) ?? 0) + Number(s.quantity));
    return m;
  }, [stock]);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return items as any[];
    return (items as any[]).filter((i) =>
      [i.code, i.name_ar, i.name_en].some((v) =>
        String(v ?? "")
          .toLowerCase()
          .includes(q),
      ),
    );
  }, [items, search]);

  const refetch = () => {
    qc.invalidateQueries({ queryKey: ["items"] });
    qc.invalidateQueries({ queryKey: ["item_stock"] });
    qc.invalidateQueries({ queryKey: ["item_primary_images"] });
    qc.invalidateQueries({ queryKey: ["item_units"] });
  };

  const catName = (id: string) =>
    (categories as any[]).find((c) => c.id === id)?.[locale === "ar" ? "name_ar" : "name_en"] ??
    "-";
  const unitName = (id: string) =>
    (units as any[]).find((u) => u.id === id)?.[locale === "ar" ? "name_ar" : "name_en"] ?? "-";

  const handleExport = () => {
    exportToExcel(
      filtered.map((i: any) => ({
        code: i.code,
        name_ar: i.name_ar,
        name_en: i.name_en,
        category: catName(i.category_id),
        unit: unitName(i.unit_id),
        last_price: i.last_purchase_price_local,
        qty: stockMap.get(i.id) ?? 0,
      })),
      "items",
    );
  };

  return (
    <div>
      <PageHeader title={t("items")}>
        <Input
          className="w-full sm:w-48"
          placeholder={t("search")}
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
        <Button variant="outline" onClick={handleExport}>
          <Download className="h-4 w-4 me-1" />
          {t("export_excel")}
        </Button>
        {can("items.import") && (
          <ImportButton categories={categories as any[]} units={units as any[]} onDone={refetch} />
        )}
        {can("items.manage") && (
          <ItemForm categories={categories as any[]} units={units as any[]} allItemUnits={allItemUnits as any[]} onDone={refetch} />
        )}
      </PageHeader>
      <DataTable
        rows={filtered}
        columns={[
          {
            key: "thumb",
            header: "",
            className: "w-12",
            cell: (r: any) => {
              const path = primaryMap.get(r.id);
              return path ? (
                <img
                  src={getPublicUrl(supabase, path)}
                  alt={r.name_ar}
                  className="h-9 w-9 rounded object-cover border"
                />
              ) : (
                <div className="h-9 w-9 rounded border bg-muted flex items-center justify-center text-muted-foreground">
                  <Images className="h-4 w-4" />
                </div>
              );
            },
          },
          { key: "code", header: t("code"), cell: (r: any) => r.code ?? "-" },
          { key: "name_ar", header: t("name_ar"), cell: (r: any) => r.name_ar },
          { key: "name_en", header: t("name_en"), cell: (r: any) => r.name_en ?? "-" },
          { key: "cat", header: t("category"), cell: (r: any) => catName(r.category_id) },
          {
            key: "unit_qty",
            header: t("current_qty"),
            cell: (r: any) => {
              const qty = stockMap.get(r.id) ?? 0;
              const baseUnitName = unitName(r.unit_id);
              // وحدات الصنف لحساب الكمية بالوحدة الأكبر
              const itemUnits = (allItemUnits as any[]).filter((iu) => iu.item_id === r.id && !iu.is_base_unit);
              const bigUnit = itemUnits.sort((a: any, b: any) => b.conversion_factor - a.conversion_factor)[0];
              return (
                <div className="tabular-nums text-sm">
                  <span className="font-medium">{fmtNum(qty, 2)}</span>
                  <span className="text-muted-foreground ms-1 text-xs">{baseUnitName}</span>
                  {bigUnit && qty >= bigUnit.conversion_factor && (
                    <span className="text-muted-foreground text-xs ms-1">
                      ({fmtNum(Math.floor(qty / bigUnit.conversion_factor), 0)} {unitName(bigUnit.unit_id)}{" "}
                      {(qty % bigUnit.conversion_factor) > 0 ? `+ ${fmtNum(qty % bigUnit.conversion_factor, 2)}` : ""})
                    </span>
                  )}
                </div>
              );
            },
          },
          {
            key: "price",
            header: t("last_price"),
            cell: (r: any) => fmtNum(r.last_purchase_price_local, 2),
          },
          {
            key: "actions",
            header: t("actions"),
            className: "w-36",
            cell: (r: any) => (
              <div className="flex gap-1">
                {/* زر gallery دائماً ظاهر */}
                <ItemImagesDialog item={r} canManage={can("items.manage")} />
                {can("items.manage") && (
                  <>
                    <ItemForm
                      row={r}
                      categories={categories as any[]}
                      units={units as any[]}
                      allItemUnits={allItemUnits as any[]}
                      onDone={refetch}
                    />
                    <ConfirmDelete
                      onConfirm={async () => {
                        const { error } = await supabase.from("items").delete().eq("id", r.id);
                        if (error) toast.error(error.message);
                        else {
                          toast.success(t("save_success"));
                          refetch();
                        }
                      }}
                    />
                  </>
                )}
              </div>
            ),
          },
        ]}
      />
    </div>
  );
}

// ─── ItemImagesDialog ─────────────────────────────────────────────────────────

function ItemImagesDialog({ item, canManage }: { item: any; canManage: boolean }) {
  const { t } = useI18n();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [uploading, setUploading] = useState(false);
  const supabase = createClient();
  const inputRef = useRef<HTMLInputElement>(null);
  // للموبايل: الصورة المحددة عند الضغط المطول
  const [menuImg, setMenuImg] = useState<any>(null);
  const longPressTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const startLongPress = (img: any) => {
    longPressTimer.current = setTimeout(() => setMenuImg(img), 500);
  };
  const cancelLongPress = () => {
    if (longPressTimer.current) clearTimeout(longPressTimer.current);
  };

  const { data: images = [], refetch: refetchImages } = useQuery({
    queryKey: ["item_images", item.id],
    queryFn: async () =>
      (
        await supabase
          .from("item_images")
          .select("*")
          .eq("item_id", item.id)
          .order("sort_order")
          .order("created_at")
      ).data ?? [],
    enabled: open,
  });

  const invalidate = () => {
    refetchImages();
    qc.invalidateQueries({ queryKey: ["item_primary_images"] });
  };

  const handleUpload = useCallback(
    async (files: FileList) => {
      if (!files.length) return;
      setUploading(true);
      const { data: u } = await supabase.auth.getUser();
      const isFirst = (images as any[]).length === 0;

      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const ext = file.name.split(".").pop();
        const path = `items/${item.id}/${Date.now()}_${i}.${ext}`;

        const { error: upErr } = await supabase.storage.from(BUCKET).upload(path, file, {
          cacheControl: "3600",
          upsert: false,
        });
        if (upErr) {
          toast.error(`${file.name}: ${upErr.message}`);
          continue;
        }

        const { data: { publicUrl } } = supabase.storage.from(BUCKET).getPublicUrl(path);

        const { error: dbErr } = await supabase.from("item_images").insert({
          item_id: item.id,
          storage_path: path,
          image_url: publicUrl,
          is_primary: isFirst && i === 0,
          sort_order: (images as any[]).length + i,
          created_by: u.user?.id,
        });
        if (dbErr) toast.error(dbErr.message);
      }

      setUploading(false);
      if (inputRef.current) inputRef.current.value = "";
      toast.success(t("images_uploaded"));
      invalidate();
    },
    [images, item.id],
  );

  const handleSetPrimary = async (imgId: string) => {
    const { error } = await supabase
      .from("item_images")
      .update({ is_primary: true })
      .eq("id", imgId);
    if (error) toast.error(error.message);
    else invalidate();
  };

  const handleDelete = async (img: any) => {
    // حذف من Storage
    await supabase.storage.from(BUCKET).remove([img.storage_path]);
    // حذف من DB
    const { error } = await supabase.from("item_images").delete().eq("id", img.id);
    if (error) toast.error(error.message);
    else {
      // إذا كانت الصورة المحذوفة هي الرئيسية، اجعل أول صورة متبقية هي الرئيسية
      if (img.is_primary) {
        const remaining = (images as any[]).filter((x: any) => x.id !== img.id);
        if (remaining.length > 0) {
          await supabase
            .from("item_images")
            .update({ is_primary: true })
            .eq("id", remaining[0].id);
        }
      }
      invalidate();
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost" size="icon" title={t("item_images")}>
          <Images className="h-4 w-4" />
        </Button>
      </DialogTrigger>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Images className="h-4 w-4" />
            {t("item_images")} — {item.name_ar}
          </DialogTitle>
        </DialogHeader>

        {/* منطقة رفع الصور */}
        {canManage && (
          <div
            className="border-2 border-dashed rounded-lg p-6 text-center cursor-pointer hover:border-primary/50 transition-colors"
            onClick={() => inputRef.current?.click()}
            onDragOver={(e) => e.preventDefault()}
            onDrop={(e) => {
              e.preventDefault();
              if (e.dataTransfer.files) handleUpload(e.dataTransfer.files);
            }}
          >
            <input
              ref={inputRef}
              type="file"
              accept="image/jpeg,image/png,image/webp,image/gif"
              multiple
              className="hidden"
              onChange={(e) => e.target.files && handleUpload(e.target.files)}
            />
            <ImagePlus className="h-8 w-8 mx-auto mb-2 text-muted-foreground" />
            <p className="text-sm text-muted-foreground">
              {uploading ? t("uploading") : t("upload_images_hint")}
            </p>
          </div>
        )}

        {/* Gallery */}
        {(images as any[]).length === 0 ? (
          <p className="text-center text-sm text-muted-foreground py-4">{t("no_images")}</p>
        ) : (
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 max-h-80 overflow-y-auto">
            {(images as any[]).map((img: any) => (
              <ContextMenu key={img.id}>
                <ContextMenuTrigger asChild>
                  {/* لمس مطول للموبايل */}
                  <div
                    className="relative rounded-lg overflow-hidden border bg-muted aspect-square select-none cursor-pointer"
                    onContextMenu={(e) => e.preventDefault()}
                    onTouchStart={() => canManage && startLongPress(img)}
                    onTouchEnd={cancelLongPress}
                    onTouchMove={cancelLongPress}
                  >
                    <img
                      src={getPublicUrl(supabase, img.storage_path)}
                      alt=""
                      className="w-full h-full object-cover"
                    />
                    {img.is_primary && (
                      <Badge className="absolute top-1 start-1 text-xs px-1.5 py-0.5 bg-yellow-500 text-white border-0">
                        <Star className="h-3 w-3 me-0.5" />
                        {t("primary")}
                      </Badge>
                    )}
                  </div>
                </ContextMenuTrigger>
                {/* كليك يمين على الديسكتوب */}
                {canManage && (
                  <ContextMenuContent className="w-48">
                    {!img.is_primary && (
                      <ContextMenuItem onClick={() => handleSetPrimary(img.id)}>
                        <Star className="h-4 w-4 me-2 text-yellow-500" />
                        {t("set_primary")}
                      </ContextMenuItem>
                    )}
                    {!img.is_primary && <ContextMenuSeparator />}
                    <ContextMenuItem
                      onClick={() => handleDelete(img)}
                      className="text-destructive focus:text-destructive"
                    >
                      <Trash2 className="h-4 w-4 me-2" />
                      {t("delete")}
                    </ContextMenuItem>
                  </ContextMenuContent>
                )}
              </ContextMenu>
            ))}
          </div>
        )}

        {/* Bottom sheet للموبايل عند الضغط المطول */}
        {menuImg && canManage && (
          <div
            className="fixed inset-0 z-50 flex items-end justify-center bg-black/40"
            onClick={() => setMenuImg(null)}
          >
            <div
              className="w-full max-w-sm rounded-t-2xl bg-background p-4 space-y-1 shadow-xl"
              onClick={(e) => e.stopPropagation()}
            >
              <p className="text-xs text-muted-foreground text-center mb-3 font-medium">
                {t("image_actions")}
              </p>
              {!menuImg.is_primary && (
                <button
                  className="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium hover:bg-muted transition-colors"
                  onClick={() => { handleSetPrimary(menuImg.id); setMenuImg(null); }}
                >
                  <Star className="h-5 w-5 text-yellow-500" />
                  {t("set_primary")}
                </button>
              )}
              <button
                className="flex w-full items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium text-destructive hover:bg-destructive/10 transition-colors"
                onClick={() => { handleDelete(menuImg); setMenuImg(null); }}
              >
                <Trash2 className="h-5 w-5" />
                {t("delete")}
              </button>
              <button
                className="flex w-full items-center justify-center rounded-lg px-4 py-3 text-sm font-medium bg-muted mt-1 transition-colors"
                onClick={() => setMenuImg(null)}
              >
                {t("cancel")}
              </button>
            </div>
          </div>
        )}

        <DialogFooter>
          <Button variant="outline" onClick={() => setOpen(false)}>
            <X className="h-4 w-4 me-1" />
            {t("close")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// ─── ItemForm ──────────────────────────────────────────────────────────────────

// ─── نوع الوحدة الفرعية داخل الفورم ─────────────────────────────────────────
interface SubUnit {
  unit_id: string;
  conversion_factor: number | "";
  is_purchase_default: boolean;
  _key: string;
}

function ItemForm({
  row,
  categories,
  units,
  allItemUnits,
  onDone,
}: {
  row?: any;
  categories: any[];
  units: any[];
  allItemUnits: any[];
  onDone: () => void;
}) {
  const { t, locale } = useI18n();
  const [open, setOpen] = useState(false);
  const [code, setCode] = useState(row?.code ?? "");
  const [name_ar, setNameAr] = useState(row?.name_ar ?? "");
  const [name_en, setNameEn] = useState(row?.name_en ?? "");
  const [category_id, setCategoryId] = useState<string | null>(row?.category_id ?? null);
  // الوحدة الرئيسية (الصغرى)
  const [unit_id, setUnitId] = useState<string | null>(row?.unit_id ?? null);
  // الوحدات الفرعية (الأكبر)
  const [subUnits, setSubUnits] = useState<SubUnit[]>([]);
  const [notes, setNotes] = useState(row?.notes ?? "");
  const [codeError, setCodeError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const supabase = createClient();

  // إعادة ضبط errors عند فتح الـ dialog
  useEffect(() => {
    if (open) { setCodeError(null); setSaving(false); }
  }, [open]);

  // عند التعديل: جلب الوحدات الفرعية — يُعاد تشغيله عند كل فتح للـ dialog
  useEffect(() => {
    if (!open) { setSubUnits([]); return; }
    if (!row?.id) { setSubUnits([]); return; }
    // استخدم async IIFE لضمان حداثة البيانات في كل مرة يُفتح الـ dialog
    (async () => {
      const { data } = await supabase
        .from("item_units")
        .select("*")
        .eq("item_id", row.id)
        .eq("is_base_unit", false)
        .order("conversion_factor");
      setSubUnits(
        (data ?? []).map((iu: any) => ({
          unit_id: iu.unit_id,
          conversion_factor: Number(iu.conversion_factor),
          is_purchase_default: iu.is_purchase_default,
          _key: iu.id,
        }))
      );
    })();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]); // open فقط — يُعاد تشغيله في كل مرة يُفتح الـ dialog

  const unitName = (uid: string) => {
    const u = units.find((x: any) => x.id === uid);
    return u?.[locale === "ar" ? "name_ar" : "name_en"] ?? "";
  };

  const addSubUnit = () => {
    setSubUnits((prev) => [
      ...prev,
      { unit_id: "", conversion_factor: 1, is_purchase_default: false, _key: `${Date.now()}` },
    ]);
  };

  const updateSub = (key: string, patch: Partial<SubUnit>) =>
    setSubUnits((prev) => prev.map((s) => (s._key === key ? { ...s, ...patch } : s)));

  const removeSub = (key: string) =>
    setSubUnits((prev) => prev.filter((s) => s._key !== key));

  // إذا وحّد المستخدم is_purchase_default على وحدة فرعية → أزله من الباقي
  const handleDefaultToggle = (key: string) => {
    setSubUnits((prev) =>
      prev.map((s) => ({
        ...s,
        is_purchase_default: s._key === key ? !s.is_purchase_default : false,
      }))
    );
  };

  const submit = async () => {
    if (!name_ar || !unit_id) return;
    setSaving(true);
    setCodeError(null);

    // ── تحقق من تكرار الكود ──
    if (code) {
      const { data: existing } = await supabase
        .from("items")
        .select("id")
        .eq("code", code.trim())
        .maybeSingle();
      if (existing && existing.id !== row?.id) {
        setCodeError(t("code_already_exists"));
        setSaving(false);
        return;
      }
    }

    const { data: u } = await supabase.auth.getUser();
    const uid = u.user?.id;

    const payload: any = {
      code: code.trim() || null,
      name_ar,
      name_en: name_en || null,
      category_id,
      unit_id,
      notes: notes || null,
    };

    let itemId = row?.id;
    if (row) {
      payload.updated_by = uid;
      const { error } = await supabase.from("items").update(payload).eq("id", row.id);
      if (error) {
        toast.error(error.message);
        setSaving(false);
        return;
      }
    } else {
      payload.created_by = uid;
      const { data: created, error } = await supabase.from("items").insert(payload).select().single();
      if (error || !created) {
        // خطأ unique constraint من DB كحماية ثانية
        if (error?.message?.includes("items_code_key")) {
          setCodeError(t("code_already_exists"));
        } else {
          toast.error(error?.message ?? t("save_error"));
        }
        setSaving(false);
        return;
      }
      itemId = created.id;
    }

    // ── حفظ الوحدات ──
    const anySubDefault = subUnits.some((s) => s.is_purchase_default);

    // 1. احذف كل وحدات الصنف وأعد الإدراج (أبسط وأضمن)
    await supabase.from("item_units").delete().eq("item_id", itemId);

    const unitsToInsert = [
      // الوحدة الأساسية
      {
        item_id: itemId,
        unit_id,
        conversion_factor: 1,
        is_base_unit: true,
        is_purchase_default: !anySubDefault,
        created_by: uid,
      },
      // الوحدات الفرعية
      ...subUnits
        .filter((s) => s.unit_id && Number(s.conversion_factor) > 0)
        .map((s) => ({
          item_id: itemId,
          unit_id: s.unit_id,
          conversion_factor: Number(s.conversion_factor),
          is_base_unit: false,
          is_purchase_default: s.is_purchase_default,
          created_by: uid,
        })),
    ];

    const { error: unitsErr } = await supabase.from("item_units").insert(unitsToInsert);
    if (unitsErr) {
      toast.error(`${t("units")}: ${unitsErr.message}`);
      setSaving(false);
      return;
    }

    toast.success(t("save_success"));
    setSaving(false);
    setOpen(false);
    setSubUnits([]);
    onDone();
  };

  // الوحدات المتاحة للفرعية (غير المستخدمة + غير الرئيسية)
  const usedUnitIds = [unit_id, ...subUnits.map((s) => s.unit_id)].filter(Boolean);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {row ? (
          <Button variant="ghost" size="icon">
            <Pencil className="h-4 w-4" />
          </Button>
        ) : (
          <Button>
            <Plus className="h-4 w-4 me-1" />
            {t("add")}
          </Button>
        )}
      </DialogTrigger>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle>
            {row ? t("edit") : t("add")} — {t("items")}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-4 max-h-[70vh] overflow-y-auto pe-1">
          {/* ── معلومات أساسية ── */}
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <div>
              <Label>{t("code")}</Label>
              <Input
                value={code}
                onChange={(e) => { setCode(e.target.value); setCodeError(null); }}
                className={codeError ? "border-destructive focus-visible:ring-destructive" : ""}
              />
              {codeError && (
                <p className="text-xs text-destructive mt-1 flex items-center gap-1">
                  <span>⚠</span> {codeError}
                </p>
              )}
            </div>
            <div>
              <Label>{t("name_ar")} *</Label>
              <Input value={name_ar} onChange={(e) => setNameAr(e.target.value)} />
            </div>
            <div>
              <Label>{t("name_en")}</Label>
              <Input value={name_en} onChange={(e) => setNameEn(e.target.value)} />
            </div>
            <div>
              <Label>{t("category")}</Label>
              <Select value={category_id ?? "_"} onValueChange={(v) => setCategoryId(v === "_" ? null : v)}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="_">{t("none")}</SelectItem>
                  {categories.map((c) => (
                    <SelectItem key={c.id} value={c.id}>{c.name_ar}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>

          {/* ── قسم الوحدات ── */}
          <div className="rounded-lg border p-3 space-y-3">
            <p className="text-sm font-medium text-muted-foreground">{t("units")}</p>

            {/* الوحدة الرئيسية */}
            <div className="flex items-center gap-2">
              <div className="flex-1">
                <Label className="text-xs">{t("base_unit")} *</Label>
                <Select value={unit_id ?? "_"} onValueChange={(v) => setUnitId(v === "_" ? null : v)}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("select")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="_">{t("none")}</SelectItem>
                    {units
                      .filter((u: any) => !subUnits.some((s) => s.unit_id === u.id))
                      .map((u: any) => (
                        <SelectItem key={u.id} value={u.id}>
                          {locale === "ar" ? u.name_ar : u.name_en}
                        </SelectItem>
                      ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="text-xs text-muted-foreground pt-5 shrink-0 whitespace-nowrap">
                = 1 {t("base")}
              </div>
            </div>

            {/* الوحدات الفرعية */}
            {subUnits.map((sub) => {
              const availForSub = units.filter(
                (u: any) => u.id !== unit_id && !subUnits.some((s) => s.unit_id === u.id && s._key !== sub._key)
              );
              return (
                <div key={sub._key} className="flex items-end gap-2 rounded-lg bg-muted/40 px-2 py-2">
                  {/* اسم الوحدة الفرعية */}
                  <div className="flex-1 min-w-0">
                    <Label className="text-xs">{t("sub_unit")}</Label>
                    <Select
                      value={sub.unit_id || "_"}
                      onValueChange={(v) => updateSub(sub._key, { unit_id: v === "_" ? "" : v })}
                    >
                      <SelectTrigger className="h-8 text-sm">
                        <SelectValue placeholder={t("select")} />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="_">{t("select")}</SelectItem>
                        {availForSub.map((u: any) => (
                          <SelectItem key={u.id} value={u.id}>
                            {locale === "ar" ? u.name_ar : u.name_en}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  {/* = */}
                  <div className="text-sm text-muted-foreground pb-1.5 shrink-0">=</div>

                  {/* معامل التحويل */}
                  <div className="w-20 shrink-0">
                    <Label className="text-xs">{unit_id ? unitName(unit_id) : t("unit")}</Label>
                    <Input
                      type="number"
                      min="0.001"
                      step="1"
                      inputMode="decimal"
                      value={sub.conversion_factor === "" ? "" : sub.conversion_factor}
                      onChange={(e) => updateSub(sub._key, { conversion_factor: e.target.value === "" ? "" : Number(e.target.value) })}
                      onBlur={() => { if (sub.conversion_factor === "" || Number(sub.conversion_factor) <= 0) updateSub(sub._key, { conversion_factor: 1 }); }}
                      className="h-8 text-sm"
                    />
                  </div>

                  {/* افتراضية للشراء */}
                  <div className="flex flex-col items-center gap-0.5 shrink-0 pb-1">
                    <Label className="text-[10px] text-center leading-tight text-muted-foreground">
                      {t("purchase_default_short")}
                    </Label>
                    <button
                      type="button"
                      onClick={() => handleDefaultToggle(sub._key)}
                      className={`h-5 w-5 rounded border-2 flex items-center justify-center transition-colors ${
                        sub.is_purchase_default
                          ? "bg-blue-500 border-blue-500"
                          : "border-muted-foreground/40"
                      }`}
                    >
                      {sub.is_purchase_default && (
                        <svg className="h-3 w-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                          <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                        </svg>
                      )}
                    </button>
                  </div>

                  {/* حذف */}
                  <Button
                    type="button"
                    size="icon"
                    variant="ghost"
                    className="h-8 w-8 shrink-0 text-destructive hover:text-destructive hover:bg-destructive/10"
                    onClick={() => removeSub(sub._key)}
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                  </Button>
                </div>
              );
            })}

            {/* زر إضافة وحدة فرعية */}
            <Button
              type="button"
              size="sm"
              variant="outline"
              className="w-full gap-1.5"
              onClick={addSubUnit}
              disabled={!unit_id}
            >
              <Plus className="h-3.5 w-3.5" />
              {t("add_sub_unit")}
            </Button>
          </div>

          {/* ملاحظات */}
          <div>
            <Label>{t("notes")}</Label>
            <Input value={notes} onChange={(e) => setNotes(e.target.value)} />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => setOpen(false)} disabled={saving}>
            {t("cancel")}
          </Button>
          <Button onClick={submit} disabled={!name_ar || !unit_id || saving}>
            {saving && <span className="me-1.5 h-3.5 w-3.5 animate-spin rounded-full border-2 border-current border-t-transparent inline-block" />}
            {t("save")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// ─── ImportButton ──────────────────────────────────────────────────────────────

function ImportButton({
  categories,
  units,
  onDone,
}: {
  categories: any[];
  units: any[];
  onDone: () => void;
}) {
  const { t } = useI18n();
  const ref = useRef<HTMLInputElement>(null);
  const [busy, setBusy] = useState(false);
  const supabase = createClient();

  const onFile = async (file: File) => {
    setBusy(true);
    try {
      const rows = await readExcelFile(file);
      const { data: u } = await supabase.auth.getUser();
      const findCat = (n: string) =>
        categories.find((c) => [c.name_ar, c.name_en, c.id].includes(n))?.id ?? null;
      const findUnit = (n: string) =>
        units.find((x) => [x.name_ar, x.name_en, x.id].includes(n))?.id ?? null;
      const payload = rows
        .filter((r: any) => r.name_ar)
        .map((r: any) => ({
          code: r.code ? String(r.code) : null,
          name_ar: String(r.name_ar),
          name_en: r.name_en ? String(r.name_en) : null,
          category_id: r.category ? findCat(String(r.category)) : null,
          unit_id: r.unit ? findUnit(String(r.unit)) : null,
          last_purchase_price_local: r.price ? Number(r.price) : 0,
          created_by: u.user?.id,
        }));
      if (!payload.length) {
        toast.error(t("import_help"));
        return;
      }
      const { error } = await supabase.from("items").insert(payload);
      if (error) {
        toast.error(error.message);
        return;
      }
      toast.success(t("rows_imported", { n: payload.length }));
      onDone();
    } catch (e: any) {
      toast.error(e.message ?? "Import failed");
    } finally {
      setBusy(false);
      if (ref.current) ref.current.value = "";
    }
  };

  return (
    <>
      <input
        ref={ref}
        type="file"
        accept=".xlsx,.xls"
        className="hidden"
        onChange={(e) => e.target.files?.[0] && onFile(e.target.files[0])}
      />
      <Button
        variant="outline"
        onClick={() => ref.current?.click()}
        disabled={busy}
        title={t("import_help")}
      >
        <Upload className="h-4 w-4 me-1" />
        {t("import_excel")}
      </Button>
    </>
  );
}
