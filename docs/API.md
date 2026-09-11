# API & Server Actions Reference

هذا المستند يصف واجهات برمجة التطبيقات الداخلية وكيفية الاتصال الآمن بين العميل (Client) والخادم (Server) في بيئة Next.js.

## نظرة عامة

بعد الترحيل إلى **Next.js App Router**، يعتمد التطبيق بالكامل على **Server Actions** لتنفيذ العمليات التي تتطلب خادماً آمناً. لا يوجد مسارات API تقليدية (REST endpoints) إلا عند الحاجة القصوى (مثلاً للويب هوكس أو الاتصال بتطبيقات خارجية)، بل يتم استدعاء دوال الخادم مباشرة من مكونات العميل.

## ما هي الـ Server Actions؟

الـ Server Actions في Next.js هي دوال غير متزامنة (Async Functions) تعمل حصراً على الخادم. يتم تمييزها باستخدام التوجيه `"use server"`.
تسمح لك هذه الدوال بتنفيذ مهام آمنة مثل:
- استخدام المفاتيح السرية مثل `SUPABASE_SERVICE_ROLE_KEY`.
- تعديل قواعد البيانات أو جلب بيانات محمية بدون القلق من تسريب المفاتيح.
- تنفيذ المصادقة والتحقق من الصلاحيات بأمان قبل أي عملية.

## كيفية إنشاء Server Action جديد

1. أنشئ الدالة في مجلد `src/app/actions/` أو `src/lib/api/` (يُفضل تجميع العمليات المرتبطة في ملف واحد، مثلاً `users.ts`).
2. ضع `"use server"` في السطر الأول من الملف أو بداخل الدالة.
3. تأكد من أن الدالة ترجع بيانات قابلة للتسلسل (Serializable) كـ JSON (بدون كائنات معقدة أو دوال).

```ts
"use server";

import { supabaseAdmin } from "@/lib/supabase/admin";

export async function updateUserStatus(userId: string, status: boolean) {
  // كود الخادم الآمن هنا
  const { error } = await supabaseAdmin
    .from("profiles")
    .update({ is_active: status })
    .eq("id", userId);
    
  if (error) throw new Error(error.message);
  
  return { success: true };
}
```

## كيفية الاستدعاء من العميل (Client)

يمكنك استيراد الـ Server Action مباشرة داخل مكونات العميل (`"use client"`) واستدعاءه كدالة عادية.

```tsx
"use client";

import { useState } from "react";
import { updateUserStatus } from "@/app/actions/users";
import { toast } from "sonner";

export function UserButton({ userId }: { userId: string }) {
  const [loading, setLoading] = useState(false);

  const handleUpdate = async () => {
    setLoading(true);
    try {
      // استدعاء مباشر لـ Server Action
      await updateUserStatus(userId, true);
      toast.success("تم التحديث بنجاح!");
    } catch (error: any) {
      toast.error(error.message);
    } finally {
      setLoading(false);
    }
  };

  return <button onClick={handleUpdate} disabled={loading}>تفعيل المستخدم</button>;
}
```

## المصادقة والصلاحيات (Authentication & RBAC)

لأن Server Actions تعمل على الخادم، يمكنك -ويجب عليك- التحقق من جلسة المستخدم قبل تنفيذ أي عملية خطيرة.
يمكنك استخدام عميل Supabase الخاص بالخادم (`createServerClient`) لقراءة الجلسة بشكل آمن عبر ملفات الكوكيز:

```ts
"use server";

import { createClient } from "@/lib/supabase/server";

export async function doSomethingSecure() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    throw new Error("غير مصرح لك بالقيام بهذه العملية");
  }

  // تنفيذ الكود...
}
```

## ملاحظات أمنية هامة ⚠️

- لا تمرر أبداً أية مفاتيح سرية كمدخلات (Arguments) إلى الـ Server Actions من العميل.
- الـ Server Actions مكشوفة برمجياً للعميل كنقاط نهاية مخفية (Hidden endpoints)؛ لذلك يجب عليك دائماً التحقق من المصادقة (Auth) بداخل الدالة نفسها حتى لو كان زر الاستدعاء مخفياً في الواجهة.
- للعمليات الإدارية التي تتخطى الـ RLS (مثل ترقية مستخدم أو حذفه نهائياً)، استخدم حصراً `supabaseAdmin`، ولكن تأكد أن المستدعي (المستخدم) لديه صلاحية المسؤول.

## نقاط نهاية HTTP التقليدية (Route Handlers)

إذا كنت بحاجة ماسة لواجهة برمجة (API) ليتم استدعاؤها من تطبيقات أخرى أو خدمات خارجية (مثلاً Webhooks)، فيمكنك إنشاؤها عبر Route Handlers في Next.js:
مثال: إضافة ملف `src/app/api/webhook/route.ts`:

```ts
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  const body = await request.json();
  // ... processing
  return NextResponse.json({ success: true });
}
```
