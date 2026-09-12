# Routes — خريطة المسارات

المسارات مبنية على هيكل المجلدات الخاص بـ Next.js App Router ضمن مجلد `src/app/`، مع استخدام Route Groups لتنظيم التخطيط (Layouts).

مجلد → مسار (أهم الصفحات):

- `src/app/page.tsx` — `/` (الصفحة الرئيسية أو تحويل إلى `/dashboard`).
- `src/app/login/page.tsx` — `/login`.
- `src/app/signup/page.tsx` — `/signup`.
- `src/app/layout.tsx` — layout الجذر ويتضمّن استيراد `styles.css`.
- `src/app/(authenticated)/layout.tsx` — layout المؤمّن، يركّب `AppSidebar` و`AppHeader`.

المسارات المؤمّنة (داخل `(authenticated)`):

- `/dashboard` — `src/app/(authenticated)/dashboard/page.tsx`
- `/items` — `src/app/(authenticated)/items/page.tsx`
- `/categories` — `src/app/(authenticated)/categories/page.tsx`
- `/customers` — `src/app/(authenticated)/customers/page.tsx`
- `/invoices` — `src/app/(authenticated)/invoices/page.tsx`
- `/movements` — `src/app/(authenticated)/movements/page.tsx`
- `/reports` — `src/app/(authenticated)/reports/page.tsx`
- `/settings` — `src/app/(authenticated)/settings/page.tsx`
- `/suppliers` — `src/app/(authenticated)/suppliers/page.tsx`
- `/units` — `src/app/(authenticated)/units/page.tsx`
- `/debts` — `src/app/(authenticated)/debts/page.tsx`
- `/users` — `src/app/(authenticated)/users/page.tsx`
- `/permission-groups` — `src/app/(authenticated)/permission-groups/page.tsx`
- `/audit-logs` — `src/app/(authenticated)/audit-logs/page.tsx`

ملاحظات:

- عمليات الحماية (guard) تتم في `middleware.ts` في جذر المشروع، والذي يمنع الوصول للصفحات المحمية بدون تسجيل دخول، ويقوم بتجديد جلسة Supabase بشكل آمن.
- دوال الواجهة الخلفية (Backend logic) تم عزلها داخل `src/app/actions` لتعمل كـ Next.js Server Actions بصلاحيات عالية وأمان.

- `/suppliers/[id]` — `src/app/(authenticated)/suppliers/[id]/page.tsx` (supplier statement)
