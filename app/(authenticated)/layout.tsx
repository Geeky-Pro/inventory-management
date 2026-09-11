"use client";

import { AppSidebar } from "@/components/next/AppSidebar";
import { AppHeader } from "@/components/next/AppHeader";
import { SidebarProvider, SidebarInset } from "@/components/ui/sidebar";

export default function AuthenticatedLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full bg-muted/30">
        <AppSidebar />
        <SidebarInset className="flex flex-col flex-1 min-w-0">
          <AppHeader />
          <main className="flex-1 p-4 md:p-6 overflow-x-auto">
            {children}
          </main>
        </SidebarInset>
      </div>
    </SidebarProvider>
  );
}
