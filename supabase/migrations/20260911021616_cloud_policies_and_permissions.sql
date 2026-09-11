drop trigger if exists "trg_profiles_updated" on "public"."profiles";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.ensure_single_base_unit()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
BEGIN
  IF NEW.is_purchase_default THEN
      UPDATE public.item_units
             SET is_purchase_default = false
                   WHERE item_id = NEW.item_id
                           AND id <> NEW.id
                                   AND is_purchase_default = true;
  END IF;
  RETURN NEW;
END $function$;

CREATE OR REPLACE FUNCTION public.ensure_single_primary_image()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
BEGIN
  IF NEW.is_primary THEN
      UPDATE public.item_images
             SET is_primary = false
                   WHERE item_id = NEW.item_id AND id <> NEW.id;
  END IF;
  RETURN NEW;
END $function$;

CREATE OR REPLACE FUNCTION public.on_invoice_item_change()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
  v_factor  NUMERIC(18,6) := COALESCE(NEW.conversion_factor, 1);
  v_base_qty NUMERIC(18,4);
  v_base_price NUMERIC(18,4);
BEGIN
  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id = NEW.invoice_id;

  v_base_qty   := NEW.quantity * v_factor;
  v_base_price := CASE WHEN v_factor > 0 THEN NEW.price_local / v_factor ELSE NEW.price_local END;

  INSERT INTO public.stock_movements (
      item_id, movement_type, quantity, unit_price_local,
      reference_table, reference_id, movement_date, created_by
  ) VALUES (
      NEW.item_id, 'purchase', v_base_qty, v_base_price,
      'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by
  );

  UPDATE public.item_units
      SET last_purchase_price_local = NEW.price_local,
          updated_at = now()
      WHERE id = NEW.item_unit_id AND NEW.item_unit_id IS NOT NULL;

  UPDATE public.items
      SET last_purchase_price_local = v_base_price,
          updated_at = now()
      WHERE id = NEW.item_id;

  RETURN NEW;
END $function$;

-- الصلاحيات
grant delete on table "public"."audit_logs" to "anon";
grant insert on table "public"."audit_logs" to "anon";
grant select on table "public"."audit_logs" to "anon";
grant update on table "public"."audit_logs" to "anon";

grant delete on table "public"."categories" to "anon";
grant insert on table "public"."categories" to "anon";
grant select on table "public"."categories" to "anon";
grant update on table "public"."categories" to "anon";

grant delete on table "public"."currencies" to "anon";
grant insert on table "public"."currencies" to "anon";
grant select on table "public"."currencies" to "anon";
grant update on table "public"."currencies" to "anon";

grant delete on table "public"."customers" to "anon";
grant insert on table "public"."customers" to "anon";
grant select on table "public"."customers" to "anon";
grant update on table "public"."customers" to "anon";

grant delete on table "public"."debt_transactions" to "anon";
grant insert on table "public"."debt_transactions" to "anon";
grant select on table "public"."debt_transactions" to "anon";
grant update on table "public"."debt_transactions" to "anon";

grant delete on table "public"."exchange_rates" to "anon";
grant insert on table "public"."exchange_rates" to "anon";
grant select on table "public"."exchange_rates" to "anon";
grant update on table "public"."exchange_rates" to "anon";

grant delete on table "public"."item_images" to "anon";
grant insert on table "public"."item_images" to "anon";
grant select on table "public"."item_images" to "anon";
grant update on table "public"."item_images" to "anon";

grant delete on table "public"."item_units" to "anon";
grant insert on table "public"."item_units" to "anon";
grant select on table "public"."item_units" to "anon";
grant update on table "public"."item_units" to "anon";

grant delete on table "public"."items" to "anon";
grant insert on table "public"."items" to "anon";
grant select on table "public"."items" to "anon";
grant update on table "public"."items" to "anon";

grant delete on table "public"."permission_group_items" to "anon";
grant insert on table "public"."permission_group_items" to "anon";
grant select on table "public"."permission_group_items" to "anon";
grant update on table "public"."permission_group_items" to "anon";

grant delete on table "public"."permission_groups" to "anon";
grant insert on table "public"."permission_groups" to "anon";
grant select on table "public"."permission_groups" to "anon";
grant update on table "public"."permission_groups" to "anon";

grant delete on table "public"."permissions" to "anon";
grant insert on table "public"."permissions" to "anon";
grant select on table "public"."permissions" to "anon";
grant update on table "public"."permissions" to "anon";

grant delete on table "public"."permissions" to "authenticated";
grant insert on table "public"."permissions" to "authenticated";
grant update on table "public"."permissions" to "authenticated";

grant delete on table "public"."profiles" to "anon";
grant insert on table "public"."profiles" to "anon";
grant select on table "public"."profiles" to "anon";
grant update on table "public"."profiles" to "anon";

grant delete on table "public"."purchase_invoice_items" to "anon";
grant insert on table "public"."purchase_invoice_items" to "anon";
grant select on table "public"."purchase_invoice_items" to "anon";
grant update on table "public"."purchase_invoice_items" to "anon";

grant delete on table "public"."purchase_invoices" to "anon";
grant insert on table "public"."purchase_invoices" to "anon";
grant select on table "public"."purchase_invoices" to "anon";
grant update on table "public"."purchase_invoices" to "anon";

grant delete on table "public"."stock_movements" to "anon";
grant insert on table "public"."stock_movements" to "anon";
grant select on table "public"."stock_movements" to "anon";
grant update on table "public"."stock_movements" to "anon";

grant delete on table "public"."suppliers" to "anon";
grant insert on table "public"."suppliers" to "anon";
grant select on table "public"."suppliers" to "anon";
grant update on table "public"."suppliers" to "anon";

grant delete on table "public"."units" to "anon";
grant insert on table "public"."units" to "anon";
grant select on table "public"."units" to "anon";
grant update on table "public"."units" to "anon";

grant delete on table "public"."user_permission_groups" to "anon";
grant insert on table "public"."user_permission_groups" to "anon";
grant select on table "public"."user_permission_groups" to "anon";
grant update on table "public"."user_permission_groups" to "anon";

grant delete on table "public"."user_permissions" to "anon";
grant insert on table "public"."user_permissions" to "anon";
grant select on table "public"."user_permissions" to "anon";
grant update on table "public"."user_permissions" to "anon";

-- سياسة profiles
drop policy if exists "user update own profile avatar" on "public"."profiles";
create policy "user update own profile avatar"
  on "public"."profiles"
  as permissive
  for update
  to authenticated
using ((id = auth.uid()))
with check ((id = auth.uid()));

-- التريجر
CREATE TRIGGER trg_profiles_updated BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
ALTER TABLE "public"."profiles" DISABLE TRIGGER "trg_profiles_updated";

-- سياسات storage.objects مع drop policy لتفادي الأخطاء
drop policy if exists "admin delete avatars" on "storage"."objects";
create policy "admin delete avatars"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'avatars'::text) AND public.has_permission(auth.uid(), 'users.manage'::text)));

drop policy if exists "auth delete item-images" on "storage"."objects";
create policy "auth delete item-images"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'item-images'::text) AND public.has_permission(auth.uid(), 'items.manage'::text)));

drop policy if exists "auth upload item-images" on "storage"."objects";
create policy "auth upload item-images"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'item-images'::text) AND public.has_permission(auth.uid(), 'items.manage'::text)));

drop policy if exists "user delete own avatar" on "storage"."objects";
create policy "user delete own avatar"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));

drop policy if exists "user select own avatar" on "storage"."objects";
create policy "user select own avatar"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));

drop policy if exists "user update own avatar" on "storage"."objects";
create policy "user update own avatar"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));

drop policy if exists "user upload own avatar" on "storage"."objects";
create policy "user upload own avatar"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));
set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.ensure_single_base_unit()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
BEGIN
  IF NEW.is_purchase_default THEN
      UPDATE public.item_units
             SET is_purchase_default = false
                   WHERE item_id = NEW.item_id
                           AND id <> NEW.id
                                   AND is_purchase_default = true;
  END IF;
  RETURN NEW;
END $function$;

CREATE OR REPLACE FUNCTION public.ensure_single_primary_image()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
BEGIN
  IF NEW.is_primary THEN
      UPDATE public.item_images
             SET is_primary = false
                   WHERE item_id = NEW.item_id AND id <> NEW.id;
  END IF;
  RETURN NEW;
END $function$;

CREATE OR REPLACE FUNCTION public.on_invoice_item_change()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
  v_factor  NUMERIC(18,6) := COALESCE(NEW.conversion_factor, 1);
  v_base_qty NUMERIC(18,4);
  v_base_price NUMERIC(18,4);
BEGIN
  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id = NEW.invoice_id;

  v_base_qty   := NEW.quantity * v_factor;
  v_base_price := CASE WHEN v_factor > 0 THEN NEW.price_local / v_factor ELSE NEW.price_local END;

  INSERT INTO public.stock_movements (
      item_id, movement_type, quantity, unit_price_local,
      reference_table, reference_id, movement_date, created_by
  ) VALUES (
      NEW.item_id, 'purchase', v_base_qty, v_base_price,
      'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by
  );

  UPDATE public.item_units
      SET last_purchase_price_local = NEW.price_local,
          updated_at = now()
      WHERE id = NEW.item_unit_id AND NEW.item_unit_id IS NOT NULL;

  UPDATE public.items
      SET last_purchase_price_local = v_base_price,
          updated_at = now()
      WHERE id = NEW.item_id;

  RETURN NEW;
END $function$;
