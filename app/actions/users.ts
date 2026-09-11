"use server";

import { resolveAuthEmail } from "@/lib/auth";
import { getAdminSupabase } from "@/lib/api/admin";

export async function createUser({ data }: { data: any }) {
  const client = getAdminSupabase();
  const resolvedEmail = data.email ?? resolveAuthEmail(data.username).email;
  const actorId = data.actorId ?? null;

  if (!resolvedEmail) throw new Error("Email is required for creating a user");

  const { data: existingProfile, error: existingError } = await client
    .from("profiles")
    .select("id")
    .eq("username", data.username)
    .maybeSingle();
  if (existingError) throw existingError;
  if (existingProfile) throw new Error("Username already exists");

  const { data: created, error: createError } = await client.auth.admin.createUser({
    email: resolvedEmail,
    password: data.password,
    email_confirm: true,
    user_metadata: {
      username: data.username,
      full_name: data.full_name ?? data.username,
    },
  });
  if (createError) throw createError;
  if (!created.user?.id) throw new Error("Failed to create user: missing id in Supabase response");

  const userId = created.user.id;

  const profileUpdate = await client.rpc("admin_update_profile", {
    p_user_id: userId,
    p_actor_id: actorId,
    p_username: data.username,
    p_full_name: data.full_name ?? null,
    p_is_active: data.is_active ?? true,
  });
  if (profileUpdate.error) {
    try {
      await client.auth.admin.deleteUser(userId);
    } catch (rollbackErr) {
      console.error("Failed to rollback created auth user after profile update error:", rollbackErr);
    }
    throw profileUpdate.error;
  }

  if (typeof data.is_active === "boolean" && data.is_active === false) {
    const { error: banError } = await client.auth.admin.updateUserById(userId, {
      ban_duration: "876000h",
    });
    if (banError) throw banError;
  }

  return { ok: true };
}

export async function updateUser({ data }: { data: any }) {
  const client = getAdminSupabase();
  const { userId, username, full_name, email, is_active, actorId } = data;

  const updatePayload: Record<string, unknown> = {};
  if (email) updatePayload.email = email;
  const userMetadata: Record<string, unknown> = {};
  if (username) userMetadata.username = username;
  if (full_name !== undefined) userMetadata.full_name = full_name;
  if (Object.keys(userMetadata).length) updatePayload.user_metadata = userMetadata;
  if (typeof is_active === "boolean") updatePayload.ban_duration = is_active ? "none" : "876000h";

  if (Object.keys(updatePayload).length) {
    const { error: updateError } = await client.auth.admin.updateUserById(
      userId,
      updatePayload as any,
    );
    if (updateError) throw updateError;
  }

  const profileUpdate: Record<string, string | boolean | null> = {};
  if (username) profileUpdate.username = username;
  if (full_name !== undefined) profileUpdate.full_name = full_name;
  if (typeof is_active === "boolean") profileUpdate.is_active = is_active;
  
  if (Object.keys(profileUpdate).length) {
    const up = await client.rpc("admin_update_profile", {
      p_user_id: userId,
      p_actor_id: actorId ?? userId,
      p_username: username ?? null,
      p_full_name: full_name ?? null,
      p_is_active: typeof is_active === "boolean" ? is_active : null,
    });
    if (up.error) throw up.error;
  }

  return { ok: true };
}

export async function deleteUser({ data }: { data: any }) {
  const client = getAdminSupabase();
  const { userId, actorId } = data;

  const prof = await client.rpc("admin_delete_user_data", {
    p_user_id: userId,
    p_actor_id: actorId ?? userId,
  });
  if (prof.error) throw new Error(`Failed to delete user data for ${userId}: ${prof.error.message}`);

  const { error: deleteError } = await client.auth.admin.deleteUser(userId);
  if (deleteError) {
    console.error(`Auth deletion failed for ${userId} after DB cleanup:`, deleteError);
    throw new Error(`Failed to delete auth user ${userId} after removing DB rows: ${deleteError.message}`);
  }

  return { ok: true };
}

export async function adminResetPassword({ data }: { data: any }) {
  const client = getAdminSupabase();
  const { userId } = data;
  
  const { data: userResult, error: userError } = await client.auth.admin.getUserById(userId);
  if (userError) throw userError;

  const email = userResult.user?.email;
  if (!email) throw new Error("User has no email to send reset to");

  const { error: resetError } = await client.auth.resetPasswordForEmail(email);
  if (resetError) throw resetError;

  return { ok: true };
}
