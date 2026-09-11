import process from "node:process";

/**
 * Server-only environment configuration for Next.js.
 * Never import this module from a Client Component.
 */
export function getServerConfig() {
  return {
    nodeEnv: process.env.NODE_ENV,
    supabaseUrl: process.env.NEXT_PUBLIC_SUPABASE_URL,
    supabasePublishableKey: process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY,
    supabaseServiceRole: process.env.SUPABASE_SERVICE_ROLE_KEY,
    auditSystemUserId: process.env.SUPABASE_AUDIT_SYSTEM_USER_ID ?? null,
  };
}
