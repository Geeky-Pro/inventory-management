drop trigger if exists "trg_profiles_updated" on "public"."profiles";


  create table "public"."item_images" (
    "id" uuid not null default gen_random_uuid(),
    "item_id" uuid not null,
    "storage_path" text not null,
    "is_primary" boolean not null default false,
    "sort_order" integer not null default 0,
    "created_by" uuid,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."item_images" enable row level security;


  create table "public"."item_units" (
    "id" uuid not null default gen_random_uuid(),
    "item_id" uuid not null,
    "unit_id" uuid not null,
    "conversion_factor" numeric(18,6) not null default 1,
    "is_base_unit" boolean not null default false,
    "is_purchase_default" boolean not null default false,
    "last_purchase_price_local" numeric(18,4) default 0,
    "created_by" uuid,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
      );


alter table "public"."item_units" enable row level security;

alter table "public"."profiles" add column "avatar_url" text;

alter table "public"."purchase_invoice_items" add column "conversion_factor" numeric(18,6) not null default 1;

alter table "public"."purchase_invoice_items" add column "item_unit_id" uuid;

CREATE INDEX idx_item_images_item ON public.item_images USING btree (item_id);

CREATE INDEX idx_item_units_item ON public.item_units USING btree (item_id);

CREATE UNIQUE INDEX item_images_pkey ON public.item_images USING btree (id);

CREATE UNIQUE INDEX item_units_item_id_unit_id_key ON public.item_units USING btree (item_id, unit_id);

CREATE UNIQUE INDEX item_units_pkey ON public.item_units USING btree (id);

alter table "public"."item_images" add constraint "item_images_pkey" PRIMARY KEY using index "item_images_pkey";

alter table "public"."item_units" add constraint "item_units_pkey" PRIMARY KEY using index "item_units_pkey";

alter table "public"."item_images" add constraint "item_images_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public.profiles(id) not valid;

alter table "public"."item_images" validate constraint "item_images_created_by_fkey";

alter table "public"."item_images" add constraint "item_images_item_id_fkey" FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE not valid;

alter table "public"."item_images" validate constraint "item_images_item_id_fkey";

alter table "public"."item_units" add constraint "item_units_conversion_factor_check" CHECK ((conversion_factor > (0)::numeric)) not valid;

alter table "public"."item_units" validate constraint "item_units_conversion_factor_check";

alter table "public"."item_units" add constraint "item_units_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public.profiles(id) not valid;

alter table "public"."item_units" validate constraint "item_units_created_by_fkey";

alter table "public"."item_units" add constraint "item_units_item_id_fkey" FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE not valid;

alter table "public"."item_units" validate constraint "item_units_item_id_fkey";

alter table "public"."item_units" add constraint "item_units_item_id_unit_id_key" UNIQUE using index "item_units_item_id_unit_id_key";

alter table "public"."item_units" add constraint "item_units_unit_id_fkey" FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE RESTRICT not valid;

alter table "public"."item_units" validate constraint "item_units_unit_id_fkey";

alter table "public"."purchase_invoice_items" add constraint "purchase_invoice_items_item_unit_id_fkey" FOREIGN KEY (item_unit_id) REFERENCES public.item_units(id) ON DELETE SET NULL not valid;

alter table "public"."purchase_invoice_items" validate constraint "purchase_invoice_items_item_unit_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.ensure_single_base_unit()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
BEGIN
  -- الوحدة الأساسية: لا يمكن تغييرها من هنا، يُعالج في الكود
    -- الوحدة الافتراضية للشراء: نلغيها من الباقي فقط إذا NEW يطلب أن تكون true
      IF NEW.is_purchase_default THEN
          UPDATE public.item_units
                SET is_purchase_default = false
                      WHERE item_id = NEW.item_id
                              AND id <> NEW.id
                                      AND is_purchase_default = true;  -- ← شرط مهم: لا تحدّث إذا لم تكن true تجنباً للـ recursion
                                        END IF;
                                          RETURN NEW;
                                          END $function$
;

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
                                                    END $function$
;

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

                                                              -- الكمية والسعر بالوحدة الأساسية
                                                                v_base_qty   := NEW.quantity * v_factor;
                                                                  v_base_price := CASE WHEN v_factor > 0 THEN NEW.price_local / v_factor ELSE NEW.price_local END;

                                                                    -- سجّل الحركة بالوحدة الأساسية
                                                                      INSERT INTO public.stock_movements (
                                                                          item_id, movement_type, quantity, unit_price_local,
                                                                              reference_table, reference_id, movement_date, created_by
                                                                                ) VALUES (
                                                                                    NEW.item_id, 'purchase', v_base_qty, v_base_price,
                                                                                        'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by
                                                                                          );

                                                                                            -- حدّث آخر سعر شراء لكل وحدة في item_units
                                                                                              UPDATE public.item_units
                                                                                                  SET last_purchase_price_local = NEW.price_local,
                                                                                                          updated_at = now()
                                                                                                              WHERE id = NEW.item_unit_id AND NEW.item_unit_id IS NOT NULL;

                                                                                                                -- حدّث السعر بالوحدة الأساسية في items
                                                                                                                  UPDATE public.items
                                                                                                                      SET last_purchase_price_local = v_base_price,
                                                                                                                              updated_at = now()
                                                                                                                                  WHERE id = NEW.item_id;

                                                                                                                                    RETURN NEW;
                                                                                                                                    END $function$
;

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

grant references on table "public"."item_images" to "anon";

grant select on table "public"."item_images" to "anon";

grant trigger on table "public"."item_images" to "anon";

grant truncate on table "public"."item_images" to "anon";

grant update on table "public"."item_images" to "anon";

grant delete on table "public"."item_images" to "authenticated";

grant insert on table "public"."item_images" to "authenticated";

grant references on table "public"."item_images" to "authenticated";

grant select on table "public"."item_images" to "authenticated";

grant trigger on table "public"."item_images" to "authenticated";

grant truncate on table "public"."item_images" to "authenticated";

grant update on table "public"."item_images" to "authenticated";

grant delete on table "public"."item_images" to "service_role";

grant insert on table "public"."item_images" to "service_role";

grant references on table "public"."item_images" to "service_role";

grant select on table "public"."item_images" to "service_role";

grant trigger on table "public"."item_images" to "service_role";

grant truncate on table "public"."item_images" to "service_role";

grant update on table "public"."item_images" to "service_role";

grant delete on table "public"."item_units" to "anon";

grant insert on table "public"."item_units" to "anon";

grant references on table "public"."item_units" to "anon";

grant select on table "public"."item_units" to "anon";

grant trigger on table "public"."item_units" to "anon";

grant truncate on table "public"."item_units" to "anon";

grant update on table "public"."item_units" to "anon";

grant delete on table "public"."item_units" to "authenticated";

grant insert on table "public"."item_units" to "authenticated";

grant references on table "public"."item_units" to "authenticated";

grant select on table "public"."item_units" to "authenticated";

grant trigger on table "public"."item_units" to "authenticated";

grant truncate on table "public"."item_units" to "authenticated";

grant update on table "public"."item_units" to "authenticated";

grant delete on table "public"."item_units" to "service_role";

grant insert on table "public"."item_units" to "service_role";

grant references on table "public"."item_units" to "service_role";

grant select on table "public"."item_units" to "service_role";

grant trigger on table "public"."item_units" to "service_role";

grant truncate on table "public"."item_units" to "service_role";

grant update on table "public"."item_units" to "service_role";

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


  create policy "auth read item_images"
  on "public"."item_images"
  as permissive
  for select
  to authenticated
using (true);



  create policy "perm delete item_images"
  on "public"."item_images"
  as permissive
  for delete
  to authenticated
using (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "perm insert item_images"
  on "public"."item_images"
  as permissive
  for insert
  to authenticated
with check (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "perm update item_images"
  on "public"."item_images"
  as permissive
  for update
  to authenticated
using (public.has_permission(auth.uid(), 'items.manage'::text))
with check (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "auth read item_units"
  on "public"."item_units"
  as permissive
  for select
  to authenticated
using (true);



  create policy "perm delete item_units"
  on "public"."item_units"
  as permissive
  for delete
  to authenticated
using (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "perm insert item_units"
  on "public"."item_units"
  as permissive
  for insert
  to authenticated
with check (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "perm update item_units"
  on "public"."item_units"
  as permissive
  for update
  to authenticated
using (public.has_permission(auth.uid(), 'items.manage'::text))
with check (public.has_permission(auth.uid(), 'items.manage'::text));



  create policy "user update own profile avatar"
  on "public"."profiles"
  as permissive
  for update
  to authenticated
using ((id = auth.uid()))
with check ((id = auth.uid()));


CREATE TRIGGER trg_single_primary_image AFTER INSERT OR UPDATE ON public.item_images FOR EACH ROW WHEN ((new.is_primary = true)) EXECUTE FUNCTION public.ensure_single_primary_image();

CREATE TRIGGER trg_single_base_unit AFTER INSERT OR UPDATE OF is_purchase_default, is_base_unit ON public.item_units FOR EACH ROW WHEN (((new.is_purchase_default = true) OR (new.is_base_unit = true))) EXECUTE FUNCTION public.ensure_single_base_unit();

CREATE TRIGGER trg_profiles_updated BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
ALTER TABLE "public"."profiles" DISABLE TRIGGER "trg_profiles_updated";


  create policy "admin delete avatars"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'avatars'::text) AND public.has_permission(auth.uid(), 'users.manage'::text)));



  create policy "auth delete item-images"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'item-images'::text) AND public.has_permission(auth.uid(), 'items.manage'::text)));



  create policy "auth upload item-images"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'item-images'::text) AND public.has_permission(auth.uid(), 'items.manage'::text)));



  create policy "user delete own avatar"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));



  create policy "user select own avatar"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));



  create policy "user update own avatar"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));



  create policy "user upload own avatar"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'avatars'::text) AND (name ~~ ((auth.uid())::text || '/%'::text))));



