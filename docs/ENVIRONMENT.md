# Environment Variables

يستخدم المشروع متغيرات بيئة للعميل والخادم. بعض المتغيرات تُحقن في جانب العميل عبر Next.js، والبعض الآخر خاص بالخادم فقط.

## متغيرات Next.js العامة

- `NEXT_PUBLIC_SUPABASE_URL` — عنوان مشروع Supabase.
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` — المفتاح القابل للنشر.

> `NEXT_PUBLIC_*` هو اصطلاح Next.js للقيم التي يمكن أن تصل إلى المتصفح. لا تضع أسرارًا بهذا الاسم.

## متغيرات الخادم

- `SUPABASE_URL` — عنوان مشروع Supabase للخادم.
- `SUPABASE_SERVICE_ROLE_KEY` — مفتاح service role للخادم فقط.
- `SUPABASE_AUDIT_SYSTEM_USER_ID` — معرف مستخدم النظام المطلوب لبعض عمليات التدقيق.

## ملاحظات مهمة

- لا تضف `SUPABASE_SERVICE_ROLE_KEY` إلى الكود العميل أو إلى ملف `.env` المرفوع إلى المستودع.
- الكود يستخدم `SUPABASE_SERVICE_ROLE_KEY` فقط؛ لم تعد هناك compatibility fallback لمتغير Vite أو متغير service-role قديم.
- `NODE_ENV` عادةً ما تكون `development` أو `production`.

## مثال `.env.local` محلي

```env
SUPABASE_URL=http://127.0.0.1:54321
NEXT_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=sb_publishable_xxx
SUPABASE_SERVICE_ROLE_KEY=sb_secret_xxx
NODE_ENV=development
```

إذا كنت تحتاج إلى مفتاح service role في بيئة CI أو خادم، خزّنه فقط في إعدادات البيئة الخاصة بالخادم ولا تضعه في التخزين المشترك.

## الملاحظة المحلية

- تم تهيئة المشروع المحلي على `project_id = inventory-management` حسب `supabase/config.toml`.
