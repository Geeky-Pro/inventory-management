"use client";

import Link from "next/link";
import { useParams, useSearchParams } from "next/navigation";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { createClient } from "@/lib/supabase/client";
import { PageHeader } from "@/components/PageHeader";
import { DataTable } from "@/components/DataTable";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { DatePicker } from "@/components/ui/date-picker";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useI18n } from "@/lib/i18n";
import { usePermissions } from "@/lib/next/permissions";
import { fmtDate, fmtNum, todayStr } from "@/lib/format";
import { Download, FileText, Plus, ArrowLeft } from "lucide-react";
import { exportToExcel } from "@/lib/excel";
import { useEffect, useState } from "react";
import { toast } from "sonner";
import { addSupplierOpeningBalance, recordSupplierPayment } from "@/app/actions/suppliers";

type Tx = {
  id: string; supplier_id: string; transaction_date: string; transaction_type: "debit"|"credit";
  amount: number; currency_code: string; amount_local: number; reference_table: string|null;
  invoice_ref: string|null; payment_method: string|null; notes: string|null; running_balance_local: number;
};

export default function SupplierStatementPage() {
  const { t } = useI18n();
  const { can } = usePermissions();
  const params = useParams<{ id: string }>();
  const search = useSearchParams();
  const supplierId = params.id;
  const action = search.get("action");
  const qc = useQueryClient();
  const supabase = createClient();
  const [dialog, setDialog] = useState(action === "payment" ? "payment" : "");
  const { data: currencies = [] } = useQuery({
    queryKey: ["currencies"],
    queryFn: async () => (await supabase.from("currencies").select("*")).data ?? [],
  });
  const { data: supplier } = useQuery({
    queryKey: ["supplier", supplierId],
    queryFn: async () => (await supabase.from("suppliers").select("*").eq("id", supplierId).single()).data,
  });
  const { data: rows = [] } = useQuery({
    queryKey: ["supplier_statement", supplierId],
    queryFn: async () => (await supabase.from("supplier_statement").select("*").eq("supplier_id", supplierId).order("transaction_date").order("created_at").order("id")).data ?? [],
  });
  const { data: balance } = useQuery({
    queryKey: ["supplier_balance", supplierId],
    queryFn: async () => (await supabase.from("supplier_balances").select("*").eq("supplier_id", supplierId).single()).data,
  });
  const refetch = () => {
    qc.invalidateQueries({ queryKey: ["supplier_statement", supplierId] });
    qc.invalidateQueries({ queryKey: ["supplier_balance", supplierId] });
    qc.invalidateQueries({ queryKey: ["suppliers"] });
  };
  useEffect(() => { if (action === "opening" || action === "payment") setDialog(action); }, [action]);

  if (!supplier) return <div className="p-6">{t("no_data")}</div>;

  const exportRows = rows as Tx[];
  const exportStatement = () => exportToExcel(exportRows.map(r => ({
    date: r.transaction_date, type: r.transaction_type, amount: r.amount, currency: r.currency_code,
    amount_local: r.amount_local, balance: r.running_balance_local, invoice_ref: r.invoice_ref,
    payment_method: r.payment_method, notes: r.notes,
  })), "supplier_statement");

  return (
    <div>
      <PageHeader title={`${t("supplier_statement")}: ${supplier.name}`}>
        <Button asChild variant="outline"><Link href="/suppliers"><ArrowLeft className="h-4 w-4 me-1" />{t("back")}</Link></Button>
        <Button variant="outline" onClick={exportStatement}><Download className="h-4 w-4 me-1" />{t("export_excel")}</Button>
        {can("suppliers.manage") && <><Button onClick={() => setDialog("opening")}><Plus className="h-4 w-4 me-1" />{t("opening_balance")}</Button>
        <Button onClick={() => setDialog("payment")}><Plus className="h-4 w-4 me-1" />{t("supplier_payment")}</Button></>}
      </PageHeader>
      <div className="grid gap-3 sm:grid-cols-3 mb-4">
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("total_debit")}</div><strong>{fmtNum(Number(balance?.total_debit ?? 0),2)}</strong></div>
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("total_credit")}</div><strong>{fmtNum(Number(balance?.total_credit ?? 0),2)}</strong></div>
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("balance")}</div><strong>{fmtNum(Number(balance?.balance ?? 0),2)}</strong></div>
      </div>
      <DataTable rows={rows} columns={[
        {key:"d",header:t("date"),cell:(r:Tx)=>fmtDate(r.transaction_date)},
        {key:"t",header:t("transaction_type"),cell:(r:Tx)=>r.transaction_type==="debit"?t("debit"):t("credit_d")},
        {key:"a",header:t("amount"),cell:(r:Tx)=>`${fmtNum(Number(r.amount),2)} ${r.currency_code}`},
        {key:"al",header:t("price_local"),cell:(r:Tx)=>fmtNum(Number(r.amount_local),2)},
        {key:"bal",header:t("balance"),cell:(r:Tx)=>fmtNum(Number(r.running_balance_local),2)},
        {key:"ref",header:t("invoice_ref"),cell:(r:Tx)=>r.invoice_ref??"-"},
        {key:"pm",header:t("payment_method"),cell:(r:Tx)=>r.payment_method?t(r.payment_method as never):"-"},
        {key:"n",header:t("notes"),cell:(r:Tx)=>r.notes??"-"},
      ]}/>
      <LedgerDialog kind={dialog} supplierId={supplierId} currencies={currencies} onClose={()=>setDialog("")} onDone={refetch}/>
    </div>
  );
}

function LedgerDialog({kind,supplierId,currencies,onClose,onDone}:{kind:string;supplierId:string;currencies:Array<{code:string;is_base?:boolean}>;onClose:()=>void;onDone:()=>void}) {
  const {t}=useI18n(); const [amount,setAmount]=useState(0); const [currency,setCurrency]=useState("YER");
  const [rate,setRate]=useState(1); const [date,setDate]=useState(todayStr()); const [method,setMethod]=useState("cash"); const [notes,setNotes]=useState("");
  if(!kind) return null;
  const submit=async()=>{ if(amount<=0||rate<=0){toast.error(t("invalid_amount"));return;} const operationId=crypto.randomUUID();
    const result=kind==="opening"
      ? await addSupplierOpeningBalance({operationId,supplierId,amountLocal:amount*rate,currencyCode:currency,exchangeRate:rate,transactionDate:date,notes})
      : await recordSupplierPayment({operationId,supplierId,amountLocal:amount*rate,currencyCode:currency,exchangeRate:rate,transactionDate:date,paymentMethod:method,notes});
    if(!result.ok){toast.error(result.error);return;} toast.success(t("save_success")); onClose(); onDone(); };
  return <Dialog open={!!kind} onOpenChange={o=>!o&&onClose()}><DialogContent><DialogHeader><DialogTitle>{kind==="opening"?t("opening_balance"):t("supplier_payment")}</DialogTitle></DialogHeader>
    <div className="grid gap-3 sm:grid-cols-2">
      <div><Label>{t("date")}</Label><DatePicker value={date} onValueChange={setDate}/></div>
      <div><Label>{t("amount")}</Label><Input type="number" min="0" step="0.01" value={amount} onChange={e=>setAmount(Number(e.target.value))}/></div>
      <div><Label>{t("currency")}</Label><Select value={currency} onValueChange={v=>{setCurrency(v);if(v===currencies.find(c=>c.is_base)?.code)setRate(1)}}><SelectTrigger><SelectValue/></SelectTrigger><SelectContent>{currencies.map((c)=><SelectItem key={c.code} value={c.code}>{c.code}</SelectItem>)}</SelectContent></Select></div>
      <div><Label>{t("exchange_rate")}</Label><Input type="number" min="0" step="0.0001" value={rate} onChange={e=>setRate(Number(e.target.value))}/></div>
      {kind==="payment"&&<div><Label>{t("payment_method")}</Label><Select value={method} onValueChange={setMethod}><SelectTrigger><SelectValue/></SelectTrigger><SelectContent>{["cash","transfer","check","other"].map(v=><SelectItem key={v} value={v}>{v==="cash"?t("cash"):v==="transfer"?t("transfer"):v==="check"?t("check"):t("other")}</SelectItem>)}</SelectContent></Select></div>}
      <div className="sm:col-span-2"><Label>{t("notes")}</Label><Input value={notes} onChange={e=>setNotes(e.target.value)}/></div>
    </div>
    <DialogFooter><Button variant="outline" onClick={onClose}>{t("cancel")}</Button><Button onClick={submit}>{t("save")}</Button></DialogFooter>
  </DialogContent></Dialog>;
}
