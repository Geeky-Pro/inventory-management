"use client";

import { AppSidebar } from "@/components/next/AppSidebar";
import { AppHeader } from "@/components/next/AppHeader";
import { SidebarProvider, SidebarInset } from "@/components/ui/sidebar";

export default function TestLayoutPage() {
  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full bg-muted/30">
        <AppSidebar />
        <SidebarInset className="flex flex-col flex-1 min-w-0">
          <AppHeader />
          <main className="flex-1 p-4 md:p-6 overflow-x-auto">
            <div className="space-y-4">
              <h1 className="text-3xl font-bold">Layout Test Page</h1>
              <p className="text-muted-foreground">
                This page verifies that the Next.js layout, design system, and RTL/LTR logic work flawlessly.
              </p>
              <div className="p-4 border rounded-xl bg-card">
                <p>Try changing the language using the button in the header!</p>
              </div>
            </div>
          </main>
        </SidebarInset>
      </div>
    </SidebarProvider>
  );
}
