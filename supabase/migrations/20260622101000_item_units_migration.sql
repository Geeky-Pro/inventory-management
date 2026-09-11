-- =====================================================
-- ITEM UNITS — وحدات متعددة لكل صنف
-- شغّله في Supabase SQL Editor
-- =====================================================

-- 1. جدول وحدات الصنف
CREATE TABLE public.item_units (
  id            UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id       UUID          NOT NULL REFERENCES public.items(id) ON DELETE CASCADE,
  unit_id       UUID          NOT NULL REFERENCES public.units(id) ON DELETE RESTRICT,
  -- معامل التحويل: كم وحدة أساسية يساوي هذا الصنف
  -- مثال: كرتون = 12 حبة → conversion_factor = 12
  -- الوحدة الأساسية دائماً factor = 1
  conversion_factor  NUMERIC(18, 6) NOT NULL DEFAULT 1 CHECK (conversion_factor > 0),
  is_base_unit       BOOLEAN       NOT NULL DEFAULT false,
  is_purchase_default BOOLEAN      NOT NULL DEFAULT false,
  -- آخر سعر شراء بهذه الوحدة (تُحدَّث تلقائياً)
  last_purchase_price_local NUMERIC(18, 4) DEFAULT 0,
  created_by    UUID          REFERENCES public.profiles(id),
  created_at    TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ   NOT NULL DEFAULT now(),
  UNIQUE (item_id, unit_id)
);

CREATE INDEX idx_item_units_item ON public.item_units(item_id);

-- 2. RLS
ALTER TABLE public.item_units ENABLE ROW LEVEL SECURITY;

CREATE POLICY "auth read item_units"
  ON public.item_units FOR SELECT TO authenticated USING (true);

CREATE POLICY "perm insert item_units"
  ON public.item_units FOR INSERT TO authenticated
  WITH CHECK (public.has_permission(auth.uid(), 'items.manage'));

CREATE POLICY "perm update item_units"
  ON public.item_units FOR UPDATE TO authenticated
  USING  (public.has_permission(auth.uid(), 'items.manage'))
  WITH CHECK (public.has_permission(auth.uid(), 'items.manage'));

CREATE POLICY "perm delete item_units"
  ON public.item_units FOR DELETE TO authenticated
  USING (public.has_permission(auth.uid(), 'items.manage'));

-- 3. Grants
GRANT SELECT, INSERT, UPDATE, DELETE ON public.item_units TO authenticated;
GRANT ALL ON public.item_units TO service_role;

-- ─────────────────────────────────────────────────────
-- 4. إضافة unit_id + conversion_factor لبنود الفاتورة
--    (لتتبع بأي وحدة تمّت عملية الشراء)
-- ─────────────────────────────────────────────────────
ALTER TABLE public.purchase_invoice_items
  ADD COLUMN IF NOT EXISTS item_unit_id UUID REFERENCES public.item_units(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS conversion_factor NUMERIC(18, 6) NOT NULL DEFAULT 1;

-- ─────────────────────────────────────────────────────
-- 5. تعديل trigger الفاتورة
--    عند الشراء بوحدة مركّبة (مثلاً كرتون = 12)
--    نسجّل الكمية بالوحدة الأساسية في stock_movements
--    ونحدّث last_purchase_price لكل وحدة
-- ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.on_invoice_item_change()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
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
END $$;

-- ─────────────────────────────────────────────────────
-- 6. Triggers لضمان وحدة أساسية واحدة فقط + وحدة شراء افتراضية واحدة
-- ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.ensure_single_base_unit()
RETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$
BEGIN
  IF NEW.is_base_unit THEN
    UPDATE public.item_units
      SET is_base_unit = false
      WHERE item_id = NEW.item_id AND id <> NEW.id;
  END IF;
  IF NEW.is_purchase_default THEN
    UPDATE public.item_units
      SET is_purchase_default = false
      WHERE item_id = NEW.item_id AND id <> NEW.id;
  END IF;
  RETURN NEW;
END $$;

CREATE TRIGGER trg_single_base_unit
  AFTER INSERT OR UPDATE ON public.item_units
  FOR EACH ROW EXECUTE FUNCTION public.ensure_single_base_unit();

-- ─────────────────────────────────────────────────────
-- 7. ترحيل البيانات الحالية
--    كل صنف له unit_id → أنشئ له سجل في item_units
--    كـ وحدة أساسية + افتراضية للشراء
-- ─────────────────────────────────────────────────────
INSERT INTO public.item_units (item_id, unit_id, conversion_factor, is_base_unit, is_purchase_default, last_purchase_price_local)
SELECT
  id AS item_id,
  unit_id,
  1 AS conversion_factor,
  true AS is_base_unit,
  true AS is_purchase_default,
  COALESCE(last_purchase_price_local, 0)
FROM public.items
WHERE unit_id IS NOT NULL
ON CONFLICT (item_id, unit_id) DO NOTHING;
