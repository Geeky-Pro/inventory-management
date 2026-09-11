# دليل ملفات المشروع (Next.js App Router)

هذا المستند يشرح ملفات المشروع الحالية وبنيته بعد الترحيل إلى Next.js.

## كيف يعمل المشروع باختصار

التطبيق مبني على Next.js (App Router) مع Supabase. المسار العام هو:

1. الدخول عبر مجلدات `src/app/*`.
2. `src/app/layout.tsx` يهيئ الغلاف العام، الترجمة، التنبيهات.
3. الصفحات المؤمنة تمر عبر مسار `src/app/(authenticated)/*` ويحميها `middleware.ts`.
4. الوصول إلى البيانات يتم عبر Server Actions في `src/app/actions/*` أو عبر `src/lib/supabase/client.ts` للعميل و`src/lib/supabase/server.ts` للخادم.

## ملفات الجذر

- `package.json`: يعرّف اسم المشروع، الأوامر، والاعتمادات.
- `next.config.ts`: إعدادات Next.js و Turbopack.
- `middleware.ts`: مصادقة مسارات Next.js مع Supabase وحماية الصفحات.
- `components.json`: إعدادات مكونات shadcn/ui.
- `.env`: متغيرات البيئة.

## مجلد `src/app/` (نظام التوجيه)

- `layout.tsx`: غلاف التطبيق الأساسي (HTML, Body).
- `page.tsx`: الصفحة الرئيسية.
- `(authenticated)/`: مجموعة مسارات (Route Group) محمية لا تظهر في الرابط، تحتوي على:
  - `layout.tsx`: غلاف المنطقة المؤمنة (يحتوي على AppSidebar و AppHeader).
  - `dashboard/page.tsx`: لوحة التحكم.
  - `items/page.tsx`: صفحة الأصناف.
  - `invoices/page.tsx`: المشتريات.
  - وغيرها من صفحات النظام...

## مجلد `src/components/`

- `AppHeader.tsx` و `AppSidebar.tsx`: تخطيط الواجهة.
- `DataTable.tsx`: جدول بيانات عام.
- `ui/`: مجلد يحتوي على لبنات الواجهة الأساسية (Radix UI + Tailwind).

## تكامل Supabase

العملاء الحاليون: `src/lib/supabase/client.ts` و`src/lib/supabase/server.ts`.

الأنواع المولدة فقط تبقى في `src/integrations/supabase/types.ts`.

`src/integrations/supabase/client.ts` و`client.server.ts` القديمان لم يعودا جزءًا من runtime.

- `client.ts`: عميل جهة العميل (Browser Client).
- `server.ts`: عميل جهة الخادم و Admin Client.
- `types.ts`: الأنواع المولدة تلقائياً من قاعدة البيانات.

## مجلد التوثيق `docs/` و السياق `context/`

تحتوي هذه المجلدات على توثيق المشروع للمطورين والمساعدين الذكيين (AI Agents) لتوجيههم للعمل حسب معايير المشروع.
