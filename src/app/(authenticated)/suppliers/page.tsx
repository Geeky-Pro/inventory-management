"use client";

import Link from "next/link";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { createClient } from "@/lib/supabase/client";
import { PageHeader } from "@/components/PageHeader";
import { DataTable } from "@/components/DataTable";
import { Button } from "@/components/ui/button";
import {
  Dialog, DialogContent, DialogFooter, DialogHeader, DialogTitle, DialogTrigger,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useI18n } from "@/lib/i18n";
import { usePermissions } from "@/lib/next/permissions";
import { cn } from "@/lib/utils";
import { Plus, Pencil, FileText, Wallet } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { ConfirmDelete } from "@/components/ConfirmDelete";
import { createSupplier, deleteSupplier, updateSupplier } from "@/app/actions/suppliers";

type SupplierRow = {
  id: string; name: string; phone: string | null; notes: string | null;
  default_currency: string | null; default_payment_type: string | null;
  balance: number;
};

export default function SuppliersPage() {
  const { t } = useI18n();
  const { can } = usePermissions();
  const qc = useQueryClient();
  const supabase = createClient();
  const { data: rows = [] } = useQuery({
    queryKey: ["suppliers"],
    queryFn: async () => {
      const [{ data: suppliers, error: suppliersError }, { data: balances, error: balancesError }] =
        await Promise.all([
          supabase.from("suppliers").select("*").order("name"),
          supabase.from("supplier_balances").select("supplier_id,balance"),
        ]);
      if (suppliersError) throw suppliersError;
      if (balancesError) throw balancesError;
      const balanceMap = new Map((balances ?? []).map((r) => [r.supplier_id, Number(r.balance ?? 0)]));
      return (suppliers ?? []).map((r) => ({
        ...r,
        balance: balanceMap.get(r.id) ?? 0,
      })) as SupplierRow[];
    },
  });
  const refetch = () => qc.invalidateQueries({ queryKey: ["suppliers"] });

  return (
    <div>
      <PageHeader title={t("suppliers")}>
        {can("suppliers.manage") && <SForm onDone={refetch} />}
      </PageHeader>
      <DataTable
        rows={rows}
        columns={[
          { key: "n", header: t("name"), cell: (r: SupplierRow) => r.name },
          { key: "p", header: t("phone"), cell: (r: SupplierRow) => r.phone ?? "-" },
          { key: "b", header: t("balance"), cell: (r: SupplierRow) => fmtBalance(r.balance) },
          {
            key: "a", header: t("actions"), className: "w-44",
            cell: (r: SupplierRow) => (
              <div className="flex gap-1">
                <Button asChild variant="ghost" size="icon" title={t("supplier_statement")}>
                  <Link href={`/suppliers/${r.id}`}><FileText className="h-4 w-4" /></Link>
                </Button>
                {can("suppliers.manage") && (
                  <>
                    <Button asChild variant="ghost" size="icon" title={t("supplier_payment")}>
                      <Link href={`/suppliers/${r.id}?action=payment`}><Wallet className="h-4 w-4" /></Link>
                    </Button>
                    <SForm row={r} onDone={refetch} />
                    <ConfirmDelete onConfirm={async () => {
                      const result = await deleteSupplier(r.id);
                      if (!result.ok) toast.error(result.error);
                      else { toast.success(t("delete_success")); refetch(); }
                    }} />
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

function fmtBalance(value: number) {
  return Number(value ?? 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function SForm({ row, onDone }: { row?: Partial<SupplierRow>; onDone: () => void }) {
  const { t } = useI18n();
  const [open, setOpen] = useState(false);
  const [name, setName] = useState(row?.name ?? "");
  const [phone, setPhone] = useState(row?.phone ?? "");
  const [notes, setNotes] = useState(row?.notes ?? "");
  const [default_currency, setDefaultCurrency] = useState(row?.default_currency ?? "_");
  const [default_payment_type, setDefaultPaymentType] = useState(row?.default_payment_type ?? "cash");
  const [nameError, setNameError] = useState("");
  const supabase = createClient();
  const { data: currencies = [] } = useQuery({
    queryKey: ["currencies"],
    queryFn: async () => (await supabase.from("currencies").select("*")).data ?? [],
  });

  const submit = async () => {
    if (!name.trim()) { setNameError(t("field_required")); return; }
    const payload = {
      name: name.trim(), phone: phone || null, notes: notes || null,
      defaultCurrency: default_currency === "_" ? null : default_currency,
      defaultPaymentType: default_payment_type,
    };
    const result = row?.id
      ? await updateSupplier(row.id, payload)
      : await createSupplier(payload);
    if (!result.ok) return toast.error(result.error);
    toast.success(t("save_success"));
    setOpen(false); setNameError(""); onDone();
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {row?.id ? <Button variant="ghost" size="icon"><Pencil className="h-4 w-4" /></Button>
          : <Button><Plus className="h-4 w-4 me-1" />{t("add")}</Button>}
      </DialogTrigger>
      <DialogContent>
        <DialogHeader><DialogTitle>{row?.id ? t("edit_supplier") : t("add_supplier")}</DialogTitle></DialogHeader>
        <div className="space-y-3">
          <div className="space-y-1"><Label>{t("name")}</Label>
            <Input value={name} onChange={e => { setName(e.target.value); setNameError(""); }}
              className={cn(nameError && "border-destructive")} aria-invalid={!!nameError} />
            {nameError && <p className="text-xs text-destructive">{nameError}</p>}
          </div>
          <div><Label>{t("phone")}</Label><Input value={phone} onChange={e => setPhone(e.target.value)} /></div>
          <div><Label>{t("default_currency")}</Label>
            <Select value={default_currency} onValueChange={setDefaultCurrency}>
              <SelectTrigger><SelectValue placeholder={t("select")} /></SelectTrigger>
              <SelectContent><SelectItem value="_">{t("none")}</SelectItem>
                {currencies.map((c: {code:string;name_ar:string}) => <SelectItem key={c.code} value={c.code}>{c.code} - {c.name_ar}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <div><Label>{t("default_payment_type")}</Label>
            <Select value={default_payment_type} onValueChange={setDefaultPaymentType}>
              <SelectTrigger><SelectValue /></SelectTrigger>
              <SelectContent><SelectItem value="cash">{t("cash")}</SelectItem><SelectItem value="credit">{t("credit")}</SelectItem></SelectContent>
            </Select>
          </div>
          <div><Label>{t("notes")}</Label><Textarea value={notes} onChange={e => setNotes(e.target.value)} /></div>
        </div>
        <DialogFooter><Button variant="outline" onClick={() => setOpen(false)}>{t("cancel")}</Button>
          <Button onClick={submit} disabled={!name.trim()}>{t("save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
