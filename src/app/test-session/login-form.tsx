'use client'

import { createClient } from '@/lib/supabase/client'
import { useState } from 'react'

export function LoginForm() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  
  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError(null)
    
    const supabase = createClient()
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })
    
    if (error) {
      setError(error.message)
      setLoading(false)
    } else {
      // Refresh the page to trigger SSR and verify cookies
      window.location.reload()
    }
  }

  return (
    <form onSubmit={handleLogin} className="space-y-4 mt-6 p-4 border rounded-lg bg-background">
      <h3 className="font-semibold text-lg border-b pb-2">تسجيل الدخول (لتجربة الكوكيز)</h3>
      <p className="text-sm text-muted-foreground">بما أن التطبيق القديم يستخدم localStorage، فلن تنتقل الجلسة تلقائياً إلى Next.js. يرجى تسجيل الدخول هنا لإنشاء ملفات تعريف الارتباط (Cookies).</p>
      
      {error && <div className="p-3 bg-destructive/10 text-destructive rounded text-sm">{error}</div>}
      
      <div className="space-y-2">
        <label className="text-sm font-medium">البريد الإلكتروني</label>
        <input 
          type="email" 
          required 
          value={email}
          onChange={e => setEmail(e.target.value)}
          className="w-full p-2 border rounded"
        />
      </div>
      
      <div className="space-y-2">
        <label className="text-sm font-medium">كلمة المرور</label>
        <input 
          type="password" 
          required 
          value={password}
          onChange={e => setPassword(e.target.value)}
          className="w-full p-2 border rounded"
        />
      </div>
      
      <button 
        type="submit" 
        disabled={loading}
        className="w-full p-2 bg-primary text-primary-foreground rounded font-medium disabled:opacity-50"
      >
        {loading ? 'جاري تسجيل الدخول...' : 'تسجيل الدخول'}
      </button>
    </form>
  )
}
