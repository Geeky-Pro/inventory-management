# Architecture — بنية المشروع

نظرة عامة سريعة:

- إطار العمل: React + Next.js (App Router).
- الباندل: Turbopack + TypeScript.
- قاعدة البيانات: Supabase (Postgres) مع RLS وسياسات صلاحيات مخصصة لكل جدول.

هيكل الملفات الرئيسي:

- `src/app/` — يحتوي على نظام التوجيه (App Router) الخاص بـ Next.js.
  - `layout.tsx` — المخطط الأساسي للتطبيق.
  - `(authenticated)/` — مجموعة المسارات المحمية، وتحتوي على مخطط مخصص وتوجيه تلقائي لغير المسجلين.
- `src/app/actions/` — خوادم الأفعال الآمنة (Server Actions) للتعامل مع قاعدة البيانات والمصادقة بعيداً عن المتصفح.
- `src/components/` — مكونات React المشتركة، مثل الرأسية (AppHeader) والشريط الجانبي (AppSidebar). الطبقة الأساسية للمكونات توجد في `src/components/ui/` باستخدام (shadcn/ui).
- `src/integrations/supabase/` — تكوين عملاء Supabase لجهة العميل (`client.ts`) ولجهة الخادم، بالإضافة إلى الـ types المولدة تلقائياً.
- `supabase/migrations/` — أوامر SQL لتعديل بنية قاعدة البيانات، تعريف الجداول، الروابط، والمشغلات (Triggers).

ملاحظات مهمة:

- يتم استخدام عميلين لـ Supabase:
  1. عميل للعميل (Browser Client): للعمليات العادية والقراءة عبر RLS، باستخدام `createBrowserClient`.
  2. عميل للخادم (Server Client/Admin): يُستخدم داخل الـ Server Actions والـ Route Handlers لرفع الصلاحيات (Service Role) متى لزم الأمر.
- التوجيه في Next.js يعتمد على المجلدات داخل `app/`، لذلك أي مجلد جديد بداخله `page.tsx` يصبح مساراً متاحاً تلقائياً.
