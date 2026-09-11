"use client";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useState } from "react";
import { I18nProvider } from "@/lib/i18n";
import { Toaster } from "@/components/ui/sonner";

export function Providers({ 
  children, 
  defaultLocale 
}: { 
  children: React.ReactNode, 
  defaultLocale?: "ar" | "en" 
}) {
  const [queryClient] = useState(() => new QueryClient());
  
  return (
    <QueryClientProvider client={queryClient}>
      <I18nProvider defaultLocale={defaultLocale}>
        {children}
        <Toaster richColors position="top-center" />
      </I18nProvider>
    </QueryClientProvider>
  );
}
