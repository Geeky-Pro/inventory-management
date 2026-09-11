-- =====================================================
-- إصلاح trigger stack overflow
-- شغّله في Supabase SQL Editor
-- =====================================================

-- المشكلة: AFTER INSERT OR UPDATE يستدعي UPDATE على نفس الجدول
-- مما يُطلق الـ trigger مجدداً → recursion لا نهاية

-- الحل: تحويله إلى BEFORE trigger يعدّل NEW مباشرة
-- بدل UPDATE على الجدول (لا يُطلق recursion)

DROP TRIGGER IF EXISTS trg_single_base_unit ON public.item_units;
DROP FUNCTION IF EXISTS public.ensure_single_base_unit();

CREATE OR REPLACE FUNCTION public.ensure_single_base_unit()
RETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$
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
END $$;

-- AFTER بدل BEFORE لأن BEFORE لا يُطلق الـ trigger للصف الحالي
-- لكن نضيف شرط WHEN لمنع الـ recursion
CREATE TRIGGER trg_single_base_unit
  AFTER INSERT OR UPDATE OF is_purchase_default, is_base_unit
  ON public.item_units
  FOR EACH ROW
  WHEN (NEW.is_purchase_default = true OR NEW.is_base_unit = true)
  EXECUTE FUNCTION public.ensure_single_base_unit();
