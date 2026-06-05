'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from '@aura/ui';

export default function RegisterPage() {
  const router = useRouter();
  const [name, setName] = useState('');
  const [organization, setOrganization] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError('');
    const response = await fetch('/api/auth', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ type: 'register', name, organization, email, password })
    });
    const result = await response.json();
    if (!response.ok) {
      setError(result.message || 'Unable to register');
      return;
    }
    localStorage.setItem('aura_token', result.token);
    localStorage.setItem('aura_user', JSON.stringify(result.user));
    router.push('/dashboard');
  }

  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 sm:px-10 lg:px-16">
      <div className="mx-auto max-w-2xl rounded-[32px] bg-white p-10 shadow-card">
        <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Create account</p>
        <h1 className="mt-4 text-4xl font-semibold text-[#0A0A0A]">Join the AURA network</h1>
        <form onSubmit={handleSubmit} className="mt-10 space-y-6">
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Full name</span>
            <input value={name} onChange={(event) => setName(event.target.value)} required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Organization / school</span>
            <input value={organization} onChange={(event) => setOrganization(event.target.value)} required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Email</span>
            <input value={email} onChange={(event) => setEmail(event.target.value)} type="email" required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Password</span>
            <input value={password} onChange={(event) => setPassword(event.target.value)} type="password" required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          {error ? <p className="text-sm text-red-600">{error}</p> : null}
          <Button type="submit" variant="solid" className="w-full">Start trial</Button>
        </form>
        <p className="mt-6 text-sm text-slate-500">Already registered? <a href="/auth/login" className="font-semibold text-[#003399]">Sign in</a></p>
      </div>
    </main>
  );
}
