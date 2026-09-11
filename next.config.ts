import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Next.js uses the app/ directory for routing.
  // The existing src/routes/ (TanStack Router) is completely separate
  // and ignored by Next.js — no collision between them.
  //
  // Styles come from the same src/styles.css (OKLCH design system).

  // Use a separate tsconfig to avoid modifying the existing one used by Vite
  typescript: {
    tsconfigPath: "./tsconfig.next.json",
  },

  // Prevent Next.js 16 from auto-generating/modifying AGENTS.md
  agentRules: false,
};

export default nextConfig;
