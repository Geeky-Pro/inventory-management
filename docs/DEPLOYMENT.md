# Deployment — بناء ونشر

ملاحظات عامة:

- المشروع SSR باستخدام Next.js؛ يمكن استهداف بيئات Edge (Cloudflare) أو Node-based servers.

خطوات بناء أساسية:

```bash
npm run build
```

لـ preview محلي:

```bash
npm run start
```

نصائح للنشر:

- إذا كنت تنشر على Cloudflare Workers/Pages: استخدم تكوينات البناء الخاصة بـ Next.js والنشر لبيئة edge. راجع `src/app/` و`middleware.ts` للتأكد من أن handler متوافق مع runtime.
- لا تنشر `SUPABASE_SERVICE_ROLE_KEY` في متغيرات client؛ خزّنها كسِرّ في إعدادات المشروع على المنصة المقصودة.
- إعداد RLS وسياسات الصلاحيات يجب أن يتم عبر Supabase project قبل الربط.
