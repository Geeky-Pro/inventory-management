import type { Metadata } from "next";
import "../src/styles.css";

export const metadata: Metadata = {
  title: "inventory-management",
  description: "Inventory Management System",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ar" dir="rtl">
      <body>{children}</body>
    </html>
  );
}
