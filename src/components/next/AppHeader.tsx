"use client";

import { SidebarTrigger } from "@/components/ui/sidebar";
import { Button } from "@/components/ui/button";
import { useI18n } from "@/lib/i18n";
import { createClient } from "@/lib/supabase/client";
import { useRouter } from "next/navigation";
import { Languages, LogOut } from "lucide-react";
import { useCurrentUser } from "@/lib/next/permissions";

export function AppHeader() {
  const { locale, setLocale, t } = useI18n();
  const router = useRouter();
  const { data: user } = useCurrentUser();
  const supabase = createClient();

  return (
    <header className="sticky top-0 z-30 min-h-[4rem] flex flex-wrap items-center gap-3 border-b border-border/40 px-4 py-2 bg-background/80 backdrop-blur-md shadow-sm transition-all">
      <SidebarTrigger className="shrink-0" />
      <div className="flex-1 min-w-0" />
      <span className="hidden max-w-[10rem] truncate text-sm text-muted-foreground sm:inline">
        {user?.profile?.full_name ?? user?.profile?.username}
      </span>
      <Button
        variant="ghost"
        size="sm"
        className="shrink-0 gap-1 px-2 sm:px-3"
        onClick={() => setLocale(locale === "ar" ? "en" : "ar")}
      >
        <Languages className="h-4 w-4" />
        <span className="hidden sm:inline">{locale === "ar" ? "EN" : "ع"}</span>
      </Button>
      <Button
        variant="ghost"
        size="sm"
        className="shrink-0 gap-1 px-2 sm:px-3"
        onClick={async () => {
          await supabase.auth.signOut();
          router.push("/login");
        }}
      >
        <LogOut className="h-4 w-4 me-1" />
        <span className="hidden sm:inline">{t("logout")}</span>
      </Button>
    </header>
  );
}
