'use client';

import { useMemo, useState } from 'react';
import { Button, Card } from '@aura/ui';

export default function LaunchpadPage() {
  const [description, setDescription] = useState('');
  const [url, setUrl] = useState('');
  const [confidence, setConfidence] = useState(72);
  const insights = useMemo(
    () => [
      'Focus on market timing and governance signals.',
      'Close gaps in analyst review before launch.',
      'Highlight risk controls to boost investor trust.'
    ],
    []
  );

  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 sm:px-10 lg:px-16 text-[#0A0A0A]">
      <div className="mx-auto max-w-5xl space-y-10">
        <div className="rounded-[40px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Launchpad</p>
          <h1 className="mt-4 text-4xl font-semibold">Venture Confidence Toolkit</h1>
          <p className="mt-4 text-sm leading-7 text-slate-300">Submit your description or URL and let AURA return a confidence score and executive recommendations.</p>
          <div className="mt-10 grid gap-6 md:grid-cols-2">
            <label className="block">
              <span className="text-sm font-medium text-slate-300">Description</span>
              <textarea value={description} onChange={(event) => setDescription(event.target.value)} rows={4} className="mt-3 w-full rounded-3xl border border-slate-700 bg-slate-900 px-4 py-3 text-sm text-white outline-none" />
            </label>
            <label className="block">
              <span className="text-sm font-medium text-slate-300">URL</span>
              <input value={url} onChange={(event) => setUrl(event.target.value)} className="mt-3 w-full rounded-3xl border border-slate-700 bg-slate-900 px-4 py-3 text-sm text-white outline-none" />
            </label>
          </div>
          <div className="mt-10 space-y-6">
            <div className="rounded-[32px] bg-white/10 p-8 text-white shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Confidence score</p>
              <p className="mt-4 text-5xl font-semibold">{confidence}%</p>
              <p className="mt-3 text-sm leading-7 text-slate-300">Simulated AI Guardian review of your venture narrative.</p>
            </div>
            <div className="grid gap-6 md:grid-cols-3">
              {insights.map((item) => (
                <Card key={item} className="rounded-[32px] bg-white/10 p-6 text-white shadow-card">
                  <p className="text-sm font-semibold">{item}</p>
                </Card>
              ))}
            </div>
          </div>
          <div className="mt-10">
            <Button href="/plans">View growth engine</Button>
          </div>
        </div>
      </div>
    </main>
  );
}
