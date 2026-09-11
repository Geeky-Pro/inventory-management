export default function TestPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="max-w-lg text-center space-y-6">
        <h1 className="text-4xl font-bold text-foreground">
          ✅ Next.js يعمل
        </h1>
        <p className="text-muted-foreground text-lg">
          هذه صفحة اختبار للتأكد من أن نظام التصميم يعمل بشكل صحيح.
        </p>

        {/* Color system test */}
        <div className="grid grid-cols-2 gap-3 text-sm">
          <div className="rounded-lg bg-primary p-3 text-primary-foreground">
            Primary
          </div>
          <div className="rounded-lg bg-secondary p-3 text-secondary-foreground">
            Secondary
          </div>
          <div className="rounded-lg bg-accent p-3 text-accent-foreground">
            Accent
          </div>
          <div className="rounded-lg bg-destructive p-3 text-destructive-foreground">
            Destructive
          </div>
          <div className="rounded-lg bg-muted p-3 text-muted-foreground">
            Muted
          </div>
          <div className="rounded-lg bg-card p-3 text-card-foreground border">
            Card
          </div>
        </div>

        {/* Font test */}
        <div className="space-y-2 border rounded-lg p-4">
          <p className="font-bold">
            اختبار خط Cairo — يجب أن يظهر بالخط العربي الصحيح
          </p>
          <p className="text-sm text-muted-foreground">
            هذا النص يجب أن يكون بخط Cairo لأن الاتجاه RTL
          </p>
        </div>
      </div>
    </div>
  );
}
