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
import { Dialog, DialogContent, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useI18n } from "@/lib/i18n";
import { usePermissions } from "@/lib/next/permissions";
import { fmtDate, fmtNum, todayStr } from "@/lib/format";
import { Download, Plus, ArrowLeft } from "lucide-react";
import { exportToExcel } from "@/lib/excel";
import { useEffect, useMemo, useState } from "react";
import { toast } from "sonner";
import { addCustomerOpeningBalance, recordCustomerPayment } from "@/app/actions/customers";

type Tx = {
  id: string; customer_id: string; transaction_date: string; transaction_type: "debit"|"credit";
  amount: number; currency_code: string; amount_local: number; reference_table: string|null;
  invoice_ref: string|null; payment_method: string|null; notes: string|null; running_balance_local: number;
};

export default function CustomerStatementPage() {
  const { t, translateError} = useI18n();
  const { can } = usePermissions();
  const params = useParams<{ id: string }>();
  const search = useSearchParams();
  const customerId = params.id;
  const action = search.get("action");
  const qc = useQueryClient();
  const supabase = createClient();
  const [dialog, setDialog] = useState(action === "payment" ? "payment" : "");
  const { data: currencies = [], isLoading: currenciesLoading } = useQuery({
    queryKey: ["currencies"],
    queryFn: async () => (await supabase.from("currencies").select("*")).data ?? [],
  });
  const { data: customer, isLoading: customerLoading } = useQuery({
    queryKey: ["customer", customerId],
    queryFn: async () => (await supabase.from("customers").select("*").eq("id", customerId).single()).data,
  });
  const { data: rows = [], isLoading: rowsLoading } = useQuery({
    queryKey: ["customer_statement", customerId],
    queryFn: async () => (await supabase.from("customer_statement").select("*").eq("customer_id", customerId).order("transaction_date").order("created_at").order("id")).data ?? [],
  });
  const { data: balance, isLoading: balanceLoading } = useQuery({
    queryKey: ["customer_balance", customerId],
    queryFn: async () => (await supabase.from("customer_balances").select("*").eq("customer_id", customerId).single()).data,
  });
  const refetch = () => {
    qc.invalidateQueries({ queryKey: ["customer_statement", customerId] });
    qc.invalidateQueries({ queryKey: ["customer_balance", customerId] });
    qc.invalidateQueries({ queryKey: ["customers"] });
  };
  useEffect(() => { if (action === "opening" || action === "payment") setDialog(action); }, [action]);

  const normalizedRows: Tx[] = useMemo(() => rows.flatMap((r) => {
    if (!r.id || !r.customer_id || !r.transaction_date || !r.transaction_type ||
        r.amount == null || !r.currency_code || r.amount_local == null || r.running_balance_local == null) {
      return [];
    }
    if (r.transaction_type !== "debit" && r.transaction_type !== "credit") return [];
    return [{ ...r, transaction_type: r.transaction_type, amount: Number(r.amount),
      amount_local: Number(r.amount_local), running_balance_local: Number(r.running_balance_local) } as Tx];
  }), [rows]);
  const exportRows = normalizedRows;
  const exportStatement = () => exportToExcel(exportRows.map(r => ({
    date: r.transaction_date, type: r.transaction_type, amount: r.amount, currency: r.currency_code,
    amount_local: r.amount_local, balance: r.running_balance_local, invoice_ref: r.invoice_ref,
    payment_method: r.payment_method, notes: r.notes,
  })), "customer_statement");

  if (customerLoading) {
    return (
      <div className="p-6 space-y-4">
        <div className="h-8 w-1/3 bg-muted animate-pulse rounded" />
        <div className="h-24 w-full bg-muted animate-pulse rounded" />
      </div>
    );
  }
  if (!customer) return <div className="p-6">{t("no_data")}</div>;

  return (
    <div>
      <PageHeader title={`${t("customer_statement")}: ${customer.name}`}>
        <Button asChild variant="outline"><Link href="/customers"><ArrowLeft className="h-4 w-4 me-1 rtl:rotate-180" />{t("back")}</Link></Button>
        <Button variant="outline" onClick={exportStatement}><Download className="h-4 w-4 me-1" />{t("export_excel")}</Button>
        {can("customers.manage") && <><Button onClick={() => setDialog("opening")}><Plus className="h-4 w-4 me-1" />{t("opening_balance")}</Button>
        <Button onClick={() => setDialog("payment")}><Plus className="h-4 w-4 me-1" />{t("credit_d")}</Button></>}
      </PageHeader>
      <div className="grid gap-3 sm:grid-cols-3 mb-4">
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("total_debit")}</div><strong className="text-emerald-600 dark:text-emerald-500">{fmtNum(Number(balance?.total_debit ?? 0),2)}</strong></div>
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("total_credit")}</div><strong className="text-destructive">{fmtNum(Number(balance?.total_credit ?? 0),2)}</strong></div>
        <div className="rounded-md border bg-card p-4"><div className="text-sm text-muted-foreground">{t("balance")}</div><strong className={Number(balance?.balance) > 0 ? "text-emerald-600 dark:text-emerald-500" : Number(balance?.balance) < 0 ? "text-destructive" : ""}>{fmtNum(Number(balance?.balance ?? 0),2)}</strong></div>
      </div>
      <DataTable isLoading={currenciesLoading || customerLoading || rowsLoading || balanceLoading} rows={normalizedRows} columns={[
        {key:"d",header:t("date"),cell:(r:Tx)=>fmtDate(r.transaction_date)},
        {key:"t",header:t("transaction_type"),cell:(r:Tx)=>r.transaction_type==="debit"?t("debit"):t("credit_d")},
        {key:"a",header:t("amount"),cell:(r:Tx)=><span className={r.transaction_type === "debit" ? "text-emerald-600 dark:text-emerald-500" : "text-destructive"}>{fmtNum(Number(r.amount),2)} {r.currency_code}</span>},
        {key:"al",header:t("price_local"),cell:(r:Tx)=><span className={r.transaction_type === "debit" ? "text-emerald-600 dark:text-emerald-500" : "text-destructive"}>{fmtNum(Number(r.amount_local),2)}</span>},
        {key:"bal",header:t("balance"),cell:(r:Tx)=><strong className={Number(r.running_balance_local) > 0 ? "text-emerald-600 dark:text-emerald-500" : Number(r.running_balance_local) < 0 ? "text-destructive" : ""}>{fmtNum(Number(r.running_balance_local),2)}</strong>},
        {key:"ref",header:t("invoice_ref"),cell:(r:Tx)=>r.invoice_ref??"-"},
        {key:"pm",header:t("payment_method"),cell:(r:Tx)=>r.payment_method?t(r.payment_method as never):"-"},
        {key:"n",header:t("notes"),cell:(r:Tx)=>r.notes??"-"},
      ]}/>
      <LedgerDialog kind={dialog} customerId={customerId} currencies={currencies} onClose={()=>setDialog("")} onDone={refetch}/>
    </div>
  );
}

function LedgerDialog({kind,customerId,currencies,onClose,onDone}:{kind:string;customerId:string;currencies:Array<{code:string;is_base?:boolean}>;onClose:()=>void;onDone:()=>void}) {
  const {t, translateError}=useI18n();
  const [amount,setAmount]=useState(0);
  const [currency,setCurrency]=useState("YER");
  const [rate,setRate]=useState(1);
  const [date,setDate]=useState(todayStr());
  const [method,setMethod]=useState("cash");
  const [notes,setNotes]=useState("");
  const [pending,setPending]=useState(false);
  const [operationId,setOperationId]=useState(() => crypto.randomUUID());
  const baseCurrency = currencies.find(c=>c.is_base)?.code;
  useEffect(() => {
    if (kind) setOperationId(crypto.randomUUID());
  }, [kind]);
  if(!kind) return null;
  const submit=async()=>{
    if(pending) return;
    if(amount<=0||rate<=0||!date){toast.error(!date?t("field_required"):t("invalid_amount"));return;}
    if(baseCurrency && currency===baseCurrency && rate!==1){toast.error(t("invalid_amount"));return;}
    setPending(true);
    const result=kind==="opening"
      ? await addCustomerOpeningBalance({operationId,customerId,amountLocal:amount*rate,currencyCode:currency,exchangeRate:rate,transactionDate:date,notes})
      : await recordCustomerPayment({operationId,customerId,amountLocal:amount*rate,currencyCode:currency,exchangeRate:rate,transactionDate:date,paymentMethod:method,notes});
    if(!result.ok){toast.error(translateError(result.error));setPending(false);return;}
    toast.success(t("save_success")); onClose(); onDone(); setPending(false);
  };
  return <Dialog open={!!kind} onOpenChange={o=>!o&&onClose()}><DialogContent><DialogHeader><DialogTitle>{kind==="opening"?t("opening_balance"):t("credit_d")}</DialogTitle></DialogHeader>
    <div className="grid gap-3 sm:grid-cols-2">
      <div><Label>{t("date")}</Label><DatePicker value={date} onValueChange={setDate}/></div>
      <div><Label>{t("amount")}</Label><Input type="number" min="0" step="0.01" value={amount} onChange={e=>setAmount(Number(e.target.value))}/></div>
      <div><Label>{t("currency")}</Label><Select value={currency} onValueChange={v=>{setCurrency(v);if(v===currencies.find(c=>c.is_base)?.code)setRate(1)}}><SelectTrigger><SelectValue/></SelectTrigger><SelectContent>{currencies.map((c)=><SelectItem key={c.code} value={c.code}>{c.code}</SelectItem>)}</SelectContent></Select></div>
      <div><Label>{t("exchange_rate")}</Label><Input type="number" min="0" step="0.0001" value={rate} disabled={!!baseCurrency && currency===baseCurrency} onChange={e=>setRate(Number(e.target.value))}/></div>
      {kind==="payment"&&<div><Label>{t("payment_method")}</Label><Select value={method} onValueChange={setMethod}><SelectTrigger><SelectValue/></SelectTrigger><SelectContent>{["cash","transfer","check","other"].map(v=><SelectItem key={v} value={v}>{v==="cash"?t("cash"):v==="transfer"?t("transfer"):v==="check"?t("check"):t("other")}</SelectItem>)}</SelectContent></Select></div>}
      <div className="sm:col-span-2"><Label>{t("notes")}</Label><Input value={notes} onChange={e=>setNotes(e.target.value)}/></div>
    </div>
    <DialogFooter><Button variant="outline" onClick={onClose}>{t("cancel")}</Button><Button onClick={submit} disabled={pending}>{pending ? t("saving") : t("save")}</Button></DialogFooter>
  </DialogContent></Dialog>;
}
