import { createClient } from '@/lib/supabase/server'
import { LoginForm } from './login-form'

export default async function TestSessionPage() {
  const supabase = await createClient()
  
  const { data, error } = await supabase.auth.getUser()
  const user = data?.user

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="max-w-2xl w-full text-center space-y-8">
        <h1 className="text-4xl font-bold text-foreground">
          🔐 اختبار مصادقة Supabase SSR
        </h1>
        
        <div className="p-6 border rounded-xl bg-card text-card-foreground shadow-sm text-left rtl:text-right">
          <h2 className="text-xl font-semibold mb-4 border-b pb-2">حالة الجلسة:</h2>
          
          {user ? (
            <div className="space-y-4">
              <div className="p-4 bg-green-500/10 text-green-700 dark:text-green-400 rounded-lg flex items-center gap-3">
                <span className="text-2xl">✅</span>
                <p className="font-medium">تم تسجيل الدخول بنجاح! Next.js تمكن من قراءة الجلسة (الكوكيز) بنجاح.</p>
              </div>
              
              <div className="grid grid-cols-3 gap-2 text-sm">
                <div className="font-semibold text-muted-foreground">User ID:</div>
                <div className="col-span-2 font-mono text-xs break-all">{user.id}</div>
                
                <div className="font-semibold text-muted-foreground">Email:</div>
                <div className="col-span-2 font-mono">{user.email || 'N/A'}</div>
                
                <div className="font-semibold text-muted-foreground">Role:</div>
                <div className="col-span-2 font-mono">{user.role}</div>
              </div>
            </div>
          ) : (
            <div className="space-y-4">
              <div className="p-4 bg-destructive/10 text-destructive rounded-lg flex flex-col gap-2">
                <div className="flex items-center gap-3">
                  <span className="text-2xl">❌</span>
                  <p className="font-medium">غير مسجل الدخول (أو لم يتم قراءة الجلسة).</p>
                </div>
                {error && (
                  <p className="text-sm mt-2 font-mono p-2 bg-background/50 rounded">
                    Error: {error.message}
                  </p>
                )}
              </div>
              
              <LoginForm />
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
