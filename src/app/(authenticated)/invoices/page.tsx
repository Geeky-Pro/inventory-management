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
import { useI18n } from "@/lib/i18n";
import { usePermissions } from "@/lib/next/permissions";
import { ConfirmDelete } from "@/components/ConfirmDelete";
import { fmtNum, fmtDate, todayStr } from "@/lib/format";
import { exportTablePDF } from "@/lib/pdf";
import { cn } from "@/lib/utils";
import { Plus, Eye, Printer, Pencil, X, Check, Loader2, Trash2 } from "lucide-react";
import { useEffect, useMemo, useRef, useState } from "react";
import { toast } from "sonner";
import { voidPurchase } from "@/app/actions/purchases";

// ─── Page ─────────────────────────────────────────────────────────────────────
export default function InvoicesPage() {
  const { t } = useI18n();
  const { can } = usePermissions();
  const qc = useQueryClient();
  const [editingInvoice, setEditingInvoice] = useState<any | null>(null);
  const supabase = createClient();

  const { data: invoices = [] } = useQuery({
    queryKey: ["purchase_invoices"],
    queryFn: async () =>
      (await supabase.from("purchase_invoices").select("*").order("invoice_date", { ascending: false })).data ?? [],
  });
  const { data: suppliers = [] } = useQuery({
    queryKey: ["suppliers"],
    queryFn: async () => (await supabase.from("suppliers").select("*")).data ?? [],
  });
  const { data: items = [] } = useQuery({
    queryKey: ["items"],
    queryFn: async () => (await supabase.from("items").select("*").order("name_ar")).data ?? [],
  });
  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: async () => (await supabase.from("categories").select("*")).data ?? [],
  });
  const { data: currencies = [] } = useQuery({
    queryKey: ["currencies"],
    queryFn: async () => (await supabase.from("currencies").select("*")).data ?? [],
  });
  const { data: units = [] } = useQuery({
    queryKey: ["units"],
    queryFn: async () => (await supabase.from("units").select("*")).data ?? [],
  });
  const { data: rawItemUnits = [] } = useQuery({
    queryKey: ["item_units"],
    queryFn: async () =>
      (await supabase.from("item_units").select("*")
        .order("is_base_unit", { ascending: false })
        .order("conversion_factor")).data ?? [],
  });

  // دمج أسماء الوحدات
  const allItemUnits = useMemo(() =>
    (rawItemUnits as any[]).map((iu) => {
      const u = (units as any[]).find((x) => x.id === iu.unit_id);
      return { ...iu, _unit_name: u?.name_ar ?? "" };
    }),
  [rawItemUnits, units]);

  const refetch = () => {
    qc.invalidateQueries({ queryKey: ["purchase_invoices"] });
    qc.invalidateQueries({ queryKey: ["item_stock"] });
    qc.invalidateQueries({ queryKey: ["items"] });
    qc.invalidateQueries({ queryKey: ["item_units"] });
  };

  const supplierName = (id: string) => (suppliers as any[]).find((s) => s.id === id)?.name ?? "-";

  return (
    <div>
      <PageHeader title={t("invoices")}>
        {can("invoices.manage") && (
          <InvoiceForm
            suppliers={suppliers as any[]}
            items={items as any[]}
            currencies={currencies as any[]}
            units={units as any[]}
            categories={categories as any[]}
            allItemUnits={allItemUnits}
            onDone={refetch}
            editing={editingInvoice}
            onCancelEdit={() => setEditingInvoice(null)}
          />
        )}
      </PageHeader>
      <DataTable
        rows={invoices}
        columns={[
          { key: "no",  header: t("invoice_no"),   cell: (r: any) => r.invoice_no },
          { key: "d",   header: t("invoice_date"),  cell: (r: any) => fmtDate(r.invoice_date) },
          { key: "sup", header: t("supplier"),      cell: (r: any) => supplierName(r.supplier_id) },
          { key: "pay", header: t("payment_type"),  cell: (r: any) => t(r.payment_type as any) },
          { key: "cur", header: t("currency"),      cell: (r: any) => r.currency_code },
          { key: "tf",  header: t("total_foreign"), cell: (r: any) => fmtNum(r.total_foreign, 2) },
          { key: "tl",  header: t("total_local"),   cell: (r: any) => fmtNum(r.total_local, 2) },
          {
            key: "actions",
            header: t("actions"),
            className: "w-36",
            cell: (r: any) => (
              <div className="flex gap-1">
                {can("invoices.manage") && r.status === "posted" && (
                  <Button variant="ghost" size="icon" title={t("edit")} onClick={() => setEditingInvoice(r)}>
                    <Pencil className="h-4 w-4" />
                  </Button>
                )}
                <InvoiceView
                  invoice={r}
                  suppliers={suppliers as any[]}
                  items={items as any[]}
                  allItemUnits={allItemUnits}
                />
                {can("invoices.manage") && r.status === "posted" && (
                  <ConfirmDelete
                    onConfirm={async () => {
                      const result = await voidPurchase({ invoiceId: r.id });
                      if (!result.ok) toast.error(result.error);
                      else { toast.success(t("save_success")); refetch(); }
                    }}
                  />
                )}
              </div>
            ),
          },
        ]}
      />
    </div>
  );
}

// ─── types ────────────────────────────────────────────────────────────────────
interface Line {
  item_id:          string | null;
  item_unit_id:     string | null;
  conversion_factor: number;
  quantity:         number | "";
  price_foreign:    number | "";
  _uid:             string;
}
interface LineError { item_id?: string; quantity?: string }
interface SubUnit {
  unit_id: string;
  conversion_factor: number | "";
  is_purchase_default: boolean;
  _key: string;
}

const genUid = () => `${Date.now()}-${Math.random().toString(36).slice(2)}`;
const emptyLine = (): Line => ({
  item_id: null, item_unit_id: null, conversion_factor: 1,
  quantity: "", price_foreign: "", _uid: genUid(),
});

// ─── SupplierForm ─────────────────────────────────────────────────────────────
function SupplierForm({
  open,
  onOpenChange,
  onCreated,
  currencies,
}: {
  open: boolean;
  onOpenChange: (v: boolean) => void;
  onCreated: (s: any) => void;
  currencies: any[];
}) {
  const { t } = useI18n();
  const qc = useQueryClient();
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [notes, setNotes] = useState("");
  const [default_currency, setDefaultCurrency] = useState("_");
  const [default_payment_type, setDefaultPaymentType] = useState("cash");
  const supabase = createClient();

  const submitSup = async () => {
    const { data: u } = await supabase.auth.getUser();
    const payload: any = { name, phone: phone || null, notes: notes || null };
    payload.default_currency = default_currency === "_" ? null : default_currency;
    payload.default_payment_type = default_payment_type;
    if (u.user?.id) payload.created_by = u.user.id;

    const { data: created, error } = await supabase.from("suppliers").insert(payload).select().single();

    if (error) { toast.error(error.message); return; }
    toast.success(t("save_success"));
    onOpenChange(false);
    onCreated(created);
    qc.invalidateQueries({ queryKey: ["suppliers"] });
    setName(""); setPhone(""); setNotes(""); setDefaultCurrency("_"); setDefaultPaymentType("cash");
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{t("add_supplier")}</DialogTitle>
        </DialogHeader>
        <div className="space-y-3">
          <div>
            <Label>{t("name")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} />
          </div>
          <div>
            <Label>{t("phone")}</Label>
            <Input value={phone} onChange={(e) => setPhone(e.target.value)} />
          </div>
          <div>
            <Label>{t("default_currency")}</Label>
            <Select value={default_currency} onValueChange={setDefaultCurrency}>
              <SelectTrigger><SelectValue placeholder={t("select")} /></SelectTrigger>
              <SelectContent>
                <SelectItem value="_">{t("none")}</SelectItem>
                {currencies.map((c) => <SelectItem key={c.code} value={c.code}>{c.code}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label>{t("default_payment_type")}</Label>
            <Select value={default_payment_type} onValueChange={setDefaultPaymentType}>
              <SelectTrigger><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="cash">{t("cash")}</SelectItem>
                <SelectItem value="credit">{t("credit")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label>{t("notes")}</Label>
            <Input value={notes} onChange={(e) => setNotes(e.target.value)} />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)}>{t("cancel")}</Button>
          <Button onClick={submitSup} disabled={!name}>{t("save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// ─── ItemFormDialog ───────────────────────────────────────────────────────────
function ItemFormDialog({
  open,
  onOpenChange,
  categories,
  units,
  onCreated,
}: {
  open: boolean;
  onOpenChange: (v: boolean) => void;
  categories: any[];
  units: any[];
  onCreated: (newItemId: string, defUnitId: string | null, defConvFactor: number) => void;
}) {
  const { t, locale } = useI18n();
  const qc = useQueryClient();
  const [code, setCode] = useState("");
  const [name_ar, setNameAr] = useState("");
  const [name_en, setNameEn] = useState("");
  const [category_id, setCategoryId] = useState<string | null>(null);
  const [unit_id, setUnitId] = useState<string | null>(null);
  const [subUnits, setSubUnits] = useState<SubUnit[]>([]);
  const [notes, setNotes] = useState("");
  const [codeError, setCodeError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const supabase = createClient();

  useEffect(() => {
    if (open) {
      setCode(""); setNameAr(""); setNameEn(""); setCategoryId(null);
      setUnitId(null); setSubUnits([]); setNotes(""); setCodeError(null); setSaving(false);
    }
  }, [open]);

  const unitName = (uid: string) => {
    const u = units.find((x: any) => x.id === uid);
    return u?.[locale === "ar" ? "name_ar" : "name_en"] ?? "";
  };

  const addSubUnit = () => setSubUnits((prev) => [...prev, { unit_id: "", conversion_factor: 1, is_purchase_default: false, _key: `${Date.now()}` }]);
  const updateSub = (key: string, patch: Partial<SubUnit>) => setSubUnits((prev) => prev.map((s) => (s._key === key ? { ...s, ...patch } : s)));
  const removeSub = (key: string) => setSubUnits((prev) => prev.filter((s) => s._key !== key));
  const handleDefaultToggle = (key: string) => setSubUnits((prev) => prev.map((s) => ({ ...s, is_purchase_default: s._key === key ? !s.is_purchase_default : false })));

  const submit = async () => {
    if (!name_ar || !unit_id) return;
    setSaving(true); setCodeError(null);

    if (code) {
      const { data: existing } = await supabase.from("items").select("id").eq("code", code.trim()).maybeSingle();
      if (existing) { setCodeError(t("code_already_exists")); setSaving(false); return; }
    }

    const { data: u } = await supabase.auth.getUser();
    const uid = u.user?.id;

    const payload: any = { code: code.trim() || null, name_ar, name_en: name_en || null, category_id, unit_id, notes: notes || null, created_by: uid };
    const { data: created, error } = await supabase.from("items").insert(payload).select().single();
    
    if (error || !created) {
      if (error?.message?.includes("items_code_key")) setCodeError(t("code_already_exists"));
      else toast.error(error?.message ?? t("save_error"));
      setSaving(false); return;
    }

    const anySubDefault = subUnits.some((s) => s.is_purchase_default);
    const unitsToInsert = [
      { item_id: created.id, unit_id, conversion_factor: 1, is_base_unit: true, is_purchase_default: !anySubDefault, created_by: uid },
      ...subUnits.filter((s) => s.unit_id && Number(s.conversion_factor) > 0).map((s) => ({
        item_id: created.id, unit_id: s.unit_id, conversion_factor: Number(s.conversion_factor), is_base_unit: false, is_purchase_default: s.is_purchase_default, created_by: uid,
      })),
    ];

    const { error: unitsErr } = await supabase.from("item_units").insert(unitsToInsert);
    if (unitsErr) { toast.error(`${t("units")}: ${unitsErr.message}`); setSaving(false); return; }

    toast.success(t("save_success"));
    setSaving(false); onOpenChange(false);

    qc.invalidateQueries({ queryKey: ["items"] });
    qc.invalidateQueries({ queryKey: ["item_units"] });

    const defUnit = unitsToInsert.find((u) => u.is_purchase_default) || unitsToInsert[0];
    onCreated(created.id, defUnit.unit_id, defUnit.conversion_factor);
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-lg">
        <DialogHeader><DialogTitle>{t("add")} — {t("items")}</DialogTitle></DialogHeader>
        <div className="space-y-4 max-h-[70vh] overflow-y-auto pe-1">
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <div>
              <Label>{t("code")}</Label>
              <Input value={code} onChange={(e) => { setCode(e.target.value); setCodeError(null); }} className={codeError ? "border-destructive focus-visible:ring-destructive" : ""} />
              {codeError && <p className="text-xs text-destructive mt-1">⚠ {codeError}</p>}
            </div>
            <div>
              <Label>{t("name_ar")} *</Label>
              <Input value={name_ar} onChange={(e) => setNameAr(e.target.value)} />
            </div>
            <div>
              <Label>{t("category")}</Label>
              <Select value={category_id ?? "_"} onValueChange={(v) => setCategoryId(v === "_" ? null : v)}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="_">{t("none")}</SelectItem>
                  {categories.map((c) => <SelectItem key={c.id} value={c.id}>{c.name_ar}</SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          </div>
          <div className="rounded-lg border p-3 space-y-3">
            <p className="text-sm font-medium text-muted-foreground">{t("units")}</p>
            <div className="flex items-center gap-2">
              <div className="flex-1">
                <Label className="text-xs">{t("base_unit")} *</Label>
                <Select value={unit_id ?? "_"} onValueChange={(v) => setUnitId(v === "_" ? null : v)}>
                  <SelectTrigger><SelectValue placeholder={t("select")} /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="_">{t("none")}</SelectItem>
                    {units.filter((u: any) => !subUnits.some((s) => s.unit_id === u.id)).map((u: any) => (
                      <SelectItem key={u.id} value={u.id}>{locale === "ar" ? u.name_ar : u.name_en}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>
            {subUnits.map((sub) => {
              const availForSub = units.filter((u: any) => u.id !== unit_id && !subUnits.some((s) => s.unit_id === u.id && s._key !== sub._key));
              return (
                <div key={sub._key} className="flex items-end gap-2 rounded-lg bg-muted/40 px-2 py-2">
                  <div className="flex-1 min-w-0">
                    <Label className="text-xs">{t("sub_unit")}</Label>
                    <Select value={sub.unit_id || "_"} onValueChange={(v) => updateSub(sub._key, { unit_id: v === "_" ? "" : v })}>
                      <SelectTrigger className="h-8 text-sm"><SelectValue placeholder={t("select")} /></SelectTrigger>
                      <SelectContent>
                        <SelectItem value="_">{t("select")}</SelectItem>
                        {availForSub.map((u: any) => <SelectItem key={u.id} value={u.id}>{locale === "ar" ? u.name_ar : u.name_en}</SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="w-20 shrink-0">
                    <Label className="text-xs">{unit_id ? unitName(unit_id) : t("unit")}</Label>
                    <Input 
                      type="number" min="0.001" step="1" inputMode="decimal"
                      value={sub.conversion_factor === "" ? "" : sub.conversion_factor} 
                      onChange={(e) => updateSub(sub._key, { conversion_factor: e.target.value === "" ? "" : Number(e.target.value) })} 
                      onBlur={() => { if (sub.conversion_factor === "" || Number(sub.conversion_factor) <= 0) updateSub(sub._key, { conversion_factor: 1 }); }}
                      className="h-8 text-sm" 
                    />
                  </div>
                  <div className="flex flex-col items-center gap-0.5 shrink-0 pb-1">
                    <Label className="text-[10px] text-center leading-tight text-muted-foreground">{t("purchase_default_short")}</Label>
                    <button type="button" onClick={() => handleDefaultToggle(sub._key)} className={`h-5 w-5 rounded border-2 flex items-center justify-center ${sub.is_purchase_default ? "bg-blue-500 border-blue-500" : "border-muted-foreground/40"}`}>
                      {sub.is_purchase_default && <Check className="h-3 w-3 text-white" />}
                    </button>
                  </div>
                  <Button type="button" size="icon" variant="ghost" className="h-8 w-8 text-destructive" onClick={() => removeSub(sub._key)}><Trash2 className="h-3.5 w-3.5" /></Button>
                </div>
              );
            })}
            <Button type="button" size="sm" variant="outline" className="w-full gap-1.5" onClick={addSubUnit} disabled={!unit_id}><Plus className="h-3.5 w-3.5" />{t("add_sub_unit")}</Button>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={saving}>{t("cancel")}</Button>
          <Button onClick={submit} disabled={!name_ar || !unit_id || saving}>
            {saving && <Loader2 className="me-1.5 h-3.5 w-3.5 animate-spin inline-block" />} {t("save")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// ─── InvoiceForm ──────────────────────────────────────────────────────────────
function InvoiceForm({
  suppliers, items, currencies, units, categories, allItemUnits,
  onDone, editing, onCancelEdit,
}: {
  suppliers: any[]; items: any[]; currencies: any[]; units: any[]; categories: any[]; allItemUnits: any[];
  onDone: () => void; editing?: any | null; onCancelEdit?: () => void;
}) {
  const { t } = useI18n();
  const [open, setOpen]             = useState(false);
  const [saving, setSaving]         = useState(false);
  const [showAddSupplier, setShowAddSupplier] = useState(false);
  const [addItemRowIdx, setAddItemRowIdx] = useState<number | null>(null);
  
  const [invoice_no, setNo]         = useState("");
  const [invoice_date, setDate]     = useState(todayStr());
  const [supplier_id, setSupplier]  = useState<string | null>(null);
  const [payment_type, setPay]      = useState("cash");
  const baseCur = (currencies as any[]).find((c) => c.is_base)?.code ?? "YER";
  const [currency_code, setCur]     = useState(baseCur);
  const [exchange_rate, setRate]    = useState<number | "">(1);
  const [notes, setNotes]           = useState("");
  const [lines, setLines]           = useState<Line[]>([emptyLine()]);
  const [fieldErrors, setFieldErrors] = useState<{ invoice_no?: string; supplier_id?: string; lines: LineError[] }>({ lines: [{}] });
  const linesEndRef = useRef<HTMLDivElement>(null);
  const supabase = createClient();

  const isForeign = currency_code !== baseCur;

  const reset = () => {
    setNo(""); setDate(todayStr()); setSupplier(null); setPay("cash");
    setCur(baseCur); setRate(1); setNotes("");
    setLines([emptyLine()]); setFieldErrors({ lines: [{}] }); setSaving(false);
  };

  useEffect(() => {
    if (!editing) { reset(); return; }
    (async () => {
      setOpen(true);
      setNo(editing.invoice_no ?? "");
      setDate(editing.invoice_date ?? todayStr());
      setSupplier(editing.supplier_id ?? null);
      setPay(editing.payment_type ?? "cash");
      setCur(editing.currency_code ?? baseCur);
      setRate(editing.exchange_rate ?? 1);
      setNotes(editing.notes ?? "");

      const { data: existingLines, error } = await supabase.from("purchase_invoice_items").select("*").eq("invoice_id", editing.id).order("created_at", { ascending: true });
      if (error) { toast.error(error.message); setLines([emptyLine()]); return; }

      setLines(existingLines?.length ? existingLines.map((l: any) => ({
        item_id: l.item_id, item_unit_id: l.item_unit_id ?? null, conversion_factor: Number(l.conversion_factor ?? 1),
        quantity: Number(l.quantity), price_foreign: Number(l.price_foreign), _uid: l.id ?? genUid(),
      })) : [emptyLine()]);
    })();
  }, [editing]); // eslint-disable-line react-hooks/exhaustive-deps

  const totals = useMemo(() => {
    let tf = 0, tl = 0;
    for (const l of lines) {
      const q = Number(l.quantity) || 0; const p = Number(l.price_foreign) || 0;
      tf += q * p; tl += (q * p) * (Number(exchange_rate) || 1);
    }
    return { tf, tl };
  }, [lines, exchange_rate]);

  const updateLine = (idx: number, patch: Partial<Line>) => {
    setLines((cur) => { const n = [...cur]; n[idx] = { ...n[idx], ...patch }; return n; });
    setFieldErrors((cur) => {
      const nl = [...(cur.lines ?? [])];
      nl[idx] = { ...(nl[idx] ?? {}), ...(patch.item_id !== undefined ? { item_id: undefined } : {}), ...(patch.quantity !== undefined ? { quantity: undefined } : {}) };
      return { ...cur, lines: nl };
    });
  };

  const addLine = () => {
    setLines((cur) => [...cur, emptyLine()]);
    setTimeout(() => linesEndRef.current?.scrollIntoView({ behavior: "smooth", block: "end" }), 60);
  };

  const handleCurrencyChange = async (v: string) => {
    setCur(v);
    if (v === baseCur) { setRate(1); return; }
    const { data } = await supabase.from("exchange_rates").select("rate_to_base").eq("currency_code", v).order("rate_date", { ascending: false }).limit(1).maybeSingle();
    setRate(data?.rate_to_base ?? 1);
  };

  const submit = async () => {
    if (saving) return;
    const errs: { invoice_no?: string; supplier_id?: string; lines: LineError[] } = { lines: lines.map(() => ({})) };
    if (!invoice_no.trim()) errs.invoice_no = t("field_required");
    if (!supplier_id) errs.supplier_id = t("field_required");
    lines.forEach((l, i) => {
      if (!l.item_id) errs.lines[i] = { ...errs.lines[i], item_id: t("field_required") };
      if (!Number(l.quantity) || Number(l.quantity) <= 0) errs.lines[i] = { ...errs.lines[i], quantity: t("field_required") };
    });
    const hasErr = !!(errs.invoice_no || errs.supplier_id || errs.lines.some((e) => e.item_id || e.quantity));
    if (hasErr) { setFieldErrors(errs); return; }

    setSaving(true);
    const { data: auth } = await supabase.auth.getUser();
    const uid = auth.user?.id;
    const rate = Number(exchange_rate) || 1;

    const linesPayload = lines.filter((l) => l.item_id && Number(l.quantity) > 0).map((l) => ({
      item_id: l.item_id!, item_unit_id: l.item_unit_id ?? null, conversion_factor: l.conversion_factor ?? 1,
      quantity: Number(l.quantity), price_foreign: Number(l.price_foreign) || 0, price_local: (Number(l.price_foreign) || 0) * rate,
      line_total_local: Number(l.quantity) * (Number(l.price_foreign) || 0) * rate,
    }));

    const header = { invoice_no, invoice_date, supplier_id, payment_type, currency_code, exchange_rate: rate, total_foreign: totals.tf, total_local: totals.tl, notes: notes || null };

    if (editing?.id) {
      const { error: e1 } = await supabase.from("purchase_invoices").update({ ...header, updated_by: uid }).eq("id", editing.id);
      if (e1) { toast.error(e1.message); setSaving(false); return; }
      await supabase.from("purchase_invoice_items").delete().eq("invoice_id", editing.id);
      const { error: e3 } = await supabase.from("purchase_invoice_items").insert(linesPayload.map((l) => ({ ...l, invoice_id: editing.id })));
      if (e3) { toast.error(e3.message); setSaving(false); return; }
      toast.success(t("edit_success"));
    } else {
      const { data: inv, error: e1 } = await supabase.from("purchase_invoices").insert({ ...header, created_by: uid }).select().single();
      if (e1 || !inv) { toast.error(e1?.message ?? ""); setSaving(false); return; }
      const { error: e2 } = await supabase.from("purchase_invoice_items").insert(linesPayload.map((l) => ({ ...l, invoice_id: inv.id })));
      if (e2) { toast.error(e2.message); setSaving(false); return; }
      toast.success(t("save_success"));
    }

    setSaving(false); setOpen(false);
    if (onCancelEdit) onCancelEdit();
    reset(); setTimeout(() => onDone(), 50);
  };

  const handleClose = () => {
    if (saving) return;
    reset(); setOpen(false);
    if (onCancelEdit) onCancelEdit();
  };

  return (
    <Dialog open={open} onOpenChange={(v) => { if (!v) handleClose(); else setOpen(true); }}>
      <DialogTrigger asChild>
        <Button onClick={() => setOpen(true)}><Plus className="h-4 w-4 me-1" />{t("add")}</Button>
      </DialogTrigger>
      <DialogContent className="max-w-4xl max-h-[90vh] flex flex-col p-0 gap-0">
        <DialogHeader className="px-6 pt-5 pb-3 border-b shrink-0"><DialogTitle>{editing ? t("edit") : t("add")} — {t("invoices")}</DialogTitle></DialogHeader>

        <div className="flex-1 overflow-y-auto px-6 py-4 space-y-4">
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
            <div className="space-y-1">
              <Label className="text-xs">{t("invoice_no")} *</Label>
              <Input value={invoice_no} onChange={(e) => { setNo(e.target.value); setFieldErrors((p) => ({ ...p, invoice_no: undefined })); }} className={cn(fieldErrors.invoice_no && "border-destructive")} />
            </div>

            <div className="space-y-1">
              <Label className="text-xs">{t("invoice_date")}</Label>
              <Input type="date" value={invoice_date} onChange={(e) => setDate(e.target.value)} />
            </div>

            <div className="space-y-1 sm:col-span-2">
              <Label className="text-xs">{t("supplier")} *</Label>
              <Select 
                value={supplier_id ?? "_"} 
                onValueChange={async (v) => {
                  if (v === "_add") { setShowAddSupplier(true); return; }
                  const id = v === "_" ? null : v;
                  setSupplier(id); setFieldErrors((p) => ({ ...p, supplier_id: undefined })); 
                  if (id) {
                    const s = suppliers.find((x) => x.id === id);
                    if (s) {
                      if (s.default_currency) await handleCurrencyChange(s.default_currency);
                      if (s.default_payment_type) setPay(s.default_payment_type);
                    }
                  }
                }}
              >
                <SelectTrigger className={cn(fieldErrors.supplier_id && "border-destructive")}><SelectValue placeholder={t("select")} /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="_">{t("select")}</SelectItem>
                  {suppliers.map((s) => <SelectItem key={s.id} value={s.id}>{s.name}</SelectItem>)}
                  <SelectItem value="_add" className="text-primary font-medium border-t mt-1 pt-1">+ {t("add_supplier")}</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-1">
              <Label className="text-xs">{t("payment_type")}</Label>
              <Select value={payment_type} onValueChange={setPay}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="cash">{t("cash")}</SelectItem>
                  <SelectItem value="credit">{t("credit")}</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-1">
              <Label className="text-xs">{t("currency")}</Label>
              <Select value={currency_code} onValueChange={handleCurrencyChange}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  {(currencies as any[]).map((c) => <SelectItem key={c.code} value={c.code}>{c.code}</SelectItem>)}
                </SelectContent>
              </Select>
            </div>

            {isForeign && (
              <div className="space-y-1">
                <Label className="text-xs">{t("exchange_rate")}</Label>
                <Input type="number" min="0" step="0.01" value={exchange_rate} onChange={(e) => setRate(e.target.value === "" ? "" : Number(e.target.value))} onBlur={() => { if (exchange_rate === "" || Number(exchange_rate) <= 0) setRate(1); }} />
              </div>
            )}

            <div className="space-y-1 col-span-2 sm:col-span-4">
              <Label className="text-xs">{t("notes")}</Label>
              <Input value={notes} onChange={(e) => setNotes(e.target.value)} />
            </div>
          </div>

          <div className="rounded-lg border overflow-hidden">
            <div className="hidden md:grid grid-cols-12 gap-2 px-3 py-2 bg-muted/50 text-xs font-semibold text-muted-foreground">
              <div className="col-span-4">{t("item")}</div>
              <div className="col-span-2">{t("unit")}</div>
              <div className="col-span-2">{t("quantity")}</div>
              <div className="col-span-2">{isForeign ? t("price_foreign") : t("price_local")}</div>
              <div className="col-span-1 text-end">{t("line_total")}</div>
              <div className="col-span-1" />
            </div>

            <div className="divide-y">
              {lines.map((l, idx) => {
                const lineUnits = allItemUnits.filter((iu: any) => iu.item_id === l.item_id);
                const lt = (Number(l.quantity) || 0) * (Number(l.price_foreign) || 0);
                const rowErr = fieldErrors.lines[idx] ?? {};
                return (
                  <div key={l._uid} className="grid grid-cols-12 gap-2 px-3 py-2 items-center">
                    <div className="col-span-12 md:col-span-4 space-y-1 md:space-y-0">
                      <Label className="text-xs md:hidden">{t("item")}</Label>
                      <Select
                        value={l.item_id ?? ""}
                        onValueChange={(v) => {
                          if (v === "_add") { setAddItemRowIdx(idx); return; }
                          const defUnit = allItemUnits.find((iu: any) => iu.item_id === v && iu.is_purchase_default);
                          updateLine(idx, {
                            item_id: v, item_unit_id: defUnit?.id ?? null, conversion_factor: defUnit?.conversion_factor ?? 1,
                            price_foreign: defUnit?.last_purchase_price_local ? defUnit.last_purchase_price_local / (Number(exchange_rate) || 1) : "",
                          });
                        }}
                      >
                        <SelectTrigger className={cn("text-sm", rowErr.item_id && "border-destructive")}><SelectValue placeholder={t("select")} /></SelectTrigger>
                        <SelectContent>
                          {items.map((it: any) => <SelectItem key={it.id} value={it.id}>{it.name_ar}{it.code ? ` (${it.code})` : ""}</SelectItem>)}
                          <SelectItem value="_add" className="text-primary font-medium border-t mt-1 pt-1">+ {t("add_item")}</SelectItem>
                        </SelectContent>
                      </Select>
                      {rowErr.item_id && <p className="text-xs text-destructive">{rowErr.item_id}</p>}
                    </div>

                    <div className="col-span-6 md:col-span-2 space-y-1 md:space-y-0">
                      <Label className="text-xs md:hidden">{t("unit")}</Label>
                      {!l.item_id ? (
                        <div className="h-9 flex items-center px-3 rounded-md border bg-muted/30 text-sm text-muted-foreground">—</div>
                      ) : lineUnits.length === 0 ? (
                        <div className="h-9 flex items-center px-3 rounded-md border bg-muted/40 text-sm text-muted-foreground">{t("no_units")}</div>
                      ) : (
                        <Select
                          value={l.item_unit_id ?? lineUnits[0]?.id ?? ""}
                          onValueChange={(v) => {
                            const iu = allItemUnits.find((x: any) => x.id === v);
                            updateLine(idx, {
                              item_unit_id: v, conversion_factor: iu?.conversion_factor ?? 1,
                              price_foreign: iu?.last_purchase_price_local ? iu.last_purchase_price_local / (Number(exchange_rate) || 1) : l.price_foreign,
                            });
                          }}
                        >
                          <SelectTrigger className="text-sm"><SelectValue /></SelectTrigger>
                          <SelectContent>
                            {lineUnits.map((iu: any) => <SelectItem key={iu.id} value={iu.id}>{iu._unit_name} {iu.is_base_unit ? ` (${t("base")})` : ` ×${fmtNum(iu.conversion_factor, 0)}`}</SelectItem>)}
                          </SelectContent>
                        </Select>
                      )}
                    </div>

                    <div className="col-span-6 md:col-span-2 space-y-1 md:space-y-0">
                      <Label className="text-xs md:hidden">{t("quantity")}</Label>
                      <Input type="number" min="0" step="0.01" inputMode="decimal" value={l.quantity === "" ? "" : l.quantity} placeholder="0" className={cn("text-sm", rowErr.quantity && "border-destructive")} onChange={(e) => updateLine(idx, { quantity: e.target.value === "" ? "" : Number(e.target.value) })} onBlur={() => { if (l.quantity === "") updateLine(idx, { quantity: 0 }); }} />
                    </div>

                    <div className="col-span-6 md:col-span-2 space-y-1 md:space-y-0">
                      <Label className="text-xs md:hidden">{isForeign ? t("price_foreign") : t("price_local")}</Label>
                      <Input type="number" min="0" step="0.01" inputMode="decimal" value={l.price_foreign === "" ? "" : l.price_foreign} placeholder="0" className="text-sm" onChange={(e) => updateLine(idx, { price_foreign: e.target.value === "" ? "" : Number(e.target.value) })} onBlur={() => { if (l.price_foreign === "") updateLine(idx, { price_foreign: 0 }); }} />
                    </div>

                    <div className="col-span-5 md:col-span-1 flex items-center justify-end"><span className="text-sm font-medium tabular-nums">{fmtNum(lt, 2)}</span></div>
                    <div className="col-span-1 flex justify-center"><Button variant="ghost" size="icon" className="h-8 w-8 text-muted-foreground hover:text-destructive" disabled={lines.length === 1} onClick={() => setLines((cur) => cur.filter((_, i) => i !== idx))}><X className="h-4 w-4" /></Button></div>
                  </div>
                );
              })}
            </div>

            <div ref={linesEndRef} className="flex flex-wrap items-center justify-between gap-3 px-3 py-2 bg-muted/20 border-t">
              <Button size="sm" variant="outline" className="gap-1.5" onClick={addLine}><Plus className="h-3.5 w-3.5" />{t("add_line")}</Button>
              <div className="flex gap-4 text-sm font-medium">
                <span>{currency_code}: <strong className="tabular-nums">{fmtNum(totals.tf, 2)}</strong></span>
                {isForeign && <span>{baseCur}: <strong className="tabular-nums">{fmtNum(totals.tl, 2)}</strong></span>}
              </div>
            </div>
          </div>
        </div>

        <DialogFooter className="px-6 py-3 border-t shrink-0 flex-row gap-2 justify-end">
          <Button variant="outline" className="gap-1.5" onClick={handleClose} disabled={saving}><X className="h-4 w-4" />{t("cancel")}</Button>
          <Button className="gap-1.5" onClick={submit} disabled={saving}>{saving ? <Loader2 className="h-4 w-4 animate-spin" /> : <Check className="h-4 w-4" />}{editing ? t("save") : t("save")}</Button>
        </DialogFooter>

        {/* المكونات الإضافية المضمنة في الفاتورة */}
        <SupplierForm open={showAddSupplier} onOpenChange={setShowAddSupplier} currencies={currencies} onCreated={(s) => { setSupplier(s.id); if (s.default_currency) void handleCurrencyChange(s.default_currency); if (s.default_payment_type) setPay(s.default_payment_type); }} />
        <ItemFormDialog 
          open={addItemRowIdx !== null} 
          onOpenChange={(v) => { if (!v) setAddItemRowIdx(null); }} 
          categories={categories} 
          units={units} 
          onCreated={(newItemId, defUnitId, defConvFactor) => {
            if (addItemRowIdx !== null) {
              updateLine(addItemRowIdx, { item_id: newItemId, item_unit_id: defUnitId, conversion_factor: defConvFactor, price_foreign: "" });
            }
            setAddItemRowIdx(null);
          }} 
        />
      </DialogContent>
    </Dialog>
  );
}

// ─── InvoiceView ──────────────────────────────────────────────────────────────
function InvoiceView({
  invoice, suppliers, items, allItemUnits,
}: {
  invoice: any; suppliers: any[]; items: any[]; allItemUnits: any[];
}) {
  const { t } = useI18n();
  const [open, setOpen] = useState(false);
  const supabase = createClient();

  const { data: lines = [] } = useQuery({
    queryKey: ["invoice_items", invoice.id, open],
    enabled: open,
    queryFn: async () =>
      (await supabase.from("purchase_invoice_items").select("*")
        .eq("invoice_id", invoice.id).order("created_at")).data ?? [],
  });

  const itemName  = (id: string) => (items as any[]).find((i) => i.id === id)?.name_ar ?? id;
  const unitLabel = (iu_id: string | null, cf: number) => {
    if (!iu_id) return "";
    const iu = allItemUnits.find((x: any) => x.id === iu_id);
    if (!iu) return "";
    return iu.is_base_unit ? iu._unit_name : `${iu._unit_name} (×${fmtNum(cf, 0)})`;
  };

  const supplierName = (id: string) => (suppliers as any[]).find((s) => s.id === id)?.name ?? "-";

  const print = () => {
    exportTablePDF({
      title: `${t("invoice_no")}: ${invoice.invoice_no}`,
      meta: [
        `${t("invoice_date")}: ${fmtDate(invoice.invoice_date)}`,
        `${t("supplier")}: ${supplierName(invoice.supplier_id)}`,
        `${t("currency")}: ${invoice.currency_code}   ${t("exchange_rate")}: ${invoice.exchange_rate}`,
      ],
      head: [t("item"), t("unit"), t("quantity"), t("price_foreign"), t("price_local"), t("line_total")],
      body: (lines as any[]).map((l) => [
        itemName(l.item_id),
        unitLabel(l.item_unit_id, l.conversion_factor),
        fmtNum(l.quantity, 2),
        fmtNum(l.price_foreign, 2),
        fmtNum(l.price_local, 2),
        fmtNum(l.line_total_local, 2),
      ]),
      filename: `invoice-${invoice.invoice_no}`,
    });
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost" size="icon"><Eye className="h-4 w-4" /></Button>
      </DialogTrigger>
      <DialogContent className="max-w-3xl max-h-[90vh] flex flex-col p-0 gap-0">
        <DialogHeader className="px-6 pt-5 pb-3 border-b shrink-0">
          <DialogTitle>{t("invoice_details")} — {invoice.invoice_no}</DialogTitle>
        </DialogHeader>

        <div className="flex-1 overflow-y-auto px-6 py-4 space-y-4">
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-sm">
            <div><span className="text-muted-foreground text-xs block">{t("invoice_date")}</span>{fmtDate(invoice.invoice_date)}</div>
            <div><span className="text-muted-foreground text-xs block">{t("supplier")}</span>{supplierName(invoice.supplier_id)}</div>
            <div><span className="text-muted-foreground text-xs block">{t("payment_type")}</span>{t(invoice.payment_type)}</div>
            <div><span className="text-muted-foreground text-xs block">{t("currency")}</span>
              {invoice.currency_code}
              {invoice.exchange_rate !== 1 && <span className="text-muted-foreground"> × {invoice.exchange_rate}</span>}
            </div>
          </div>

          <div className="rounded-lg border overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-muted/50">
                <tr>
                  <th className="px-3 py-2 text-start font-semibold text-xs text-muted-foreground">{t("item")}</th>
                  <th className="px-3 py-2 text-start font-semibold text-xs text-muted-foreground">{t("unit")}</th>
                  <th className="px-3 py-2 text-end font-semibold text-xs text-muted-foreground">{t("quantity")}</th>
                  <th className="px-3 py-2 text-end font-semibold text-xs text-muted-foreground">{t("price_foreign")}</th>
                  {invoice.currency_code !== invoice.base_currency && (
                    <th className="px-3 py-2 text-end font-semibold text-xs text-muted-foreground">{t("price_local")}</th>
                  )}
                  <th className="px-3 py-2 text-end font-semibold text-xs text-muted-foreground">{t("line_total")}</th>
                </tr>
              </thead>
              <tbody className="divide-y">
                {(lines as any[]).map((l, i) => (
                  <tr key={i} className="hover:bg-muted/20 transition-colors">
                    <td className="px-3 py-2 font-medium">{itemName(l.item_id)}</td>
                    <td className="px-3 py-2 text-muted-foreground">{unitLabel(l.item_unit_id, l.conversion_factor) || "—"}</td>
                    <td className="px-3 py-2 text-end tabular-nums">{fmtNum(l.quantity, 2)}</td>
                    <td className="px-3 py-2 text-end tabular-nums">{fmtNum(l.price_foreign, 2)}</td>
                    {invoice.currency_code !== invoice.base_currency && (
                      <td className="px-3 py-2 text-end tabular-nums">{fmtNum(l.price_local, 2)}</td>
                    )}
                    <td className="px-3 py-2 text-end tabular-nums font-medium">{fmtNum(l.line_total_local, 2)}</td>
                  </tr>
                ))}
              </tbody>
              <tfoot className="border-t bg-muted/30">
                <tr>
                  <td colSpan={3} className="px-3 py-2 font-semibold text-sm">{t("total")}</td>
                  <td className="px-3 py-2 text-end tabular-nums font-bold">{fmtNum(invoice.total_foreign, 2)}</td>
                  {invoice.currency_code !== invoice.base_currency && (
                    <td className="px-3 py-2 text-end tabular-nums font-bold">{fmtNum(invoice.total_local / invoice.exchange_rate, 2)}</td>
                  )}
                  <td className="px-3 py-2 text-end tabular-nums font-bold">{fmtNum(invoice.total_local, 2)}</td>
                </tr>
              </tfoot>
            </table>
          </div>

          {invoice.notes && (
            <div className="text-sm"><span className="text-muted-foreground">{t("notes")}: </span>{invoice.notes}</div>
          )}
        </div>

        <DialogFooter className="px-6 py-3 border-t shrink-0">
          <Button variant="outline" onClick={print} className="gap-1.5"><Printer className="h-4 w-4" />{t("print")}</Button>
          <Button variant="outline" onClick={() => setOpen(false)}>{t("close")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
