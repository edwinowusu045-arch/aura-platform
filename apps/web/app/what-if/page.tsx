'use client';

import { useMemo, useState } from 'react';
import { Button, Card } from '@aura/ui';

export default function WhatIfPage() {
  const [adjustment, setAdjustment] = useState(0);
  const revenueImpact = useMemo(() => (120 * (1 + adjustment / 100)).toFixed(1), [adjustment]);
  const profitImpact = useMemo(() => (32 * (1 + adjustment / 100)).toFixed(1), [adjustment]);

  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 sm:px-10 lg:px-16 text-[#0A0A0A]">
      <div className="mx-auto max-w-5xl space-y-10">
        <div className="rounded-[40px] bg-white p-10 shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">What-if simulator</p>
          <h1 className="mt-4 text-4xl font-semibold">Simulate revenue and profit impact</h1>
          <p className="mt-4 text-sm leading-7 text-[#4B5563]">Adjust the forecast and see how confidence shifts across the enterprise plan.</p>
          <div className="mt-10 space-y-8">
            <div>
              <div className="flex items-center justify-between text-sm text-[#374151]">
                <span>Scenario shift</span>
                <span>{adjustment}%</span>
              </div>
              <input type="range" min="-50" max="50" value={adjustment} onChange={(event) => setAdjustment(Number(event.target.value))} className="mt-4 w-full" />
            </div>
            <div className="grid gap-6 md:grid-cols-2">
              <Card className="rounded-[32px] p-8 shadow-card">
                <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Estimated revenue</p>
                <p className="mt-4 text-4xl font-semibold">${revenueImpact}M</p>
                <p className="mt-3 text-sm text-[#4B5563]">Simulated enterprise revenue with a {adjustment}% scenario adjustment.</p>
              </Card>
              <Card className="rounded-[32px] p-8 shadow-card">
                <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Estimated profit</p>
                <p className="mt-4 text-4xl font-semibold">${profitImpact}M</p>
                <p className="mt-3 text-sm text-[#4B5563]">Projected margin based on current forecast assumptions.</p>
              </Card>
            </div>
          </div>
          <div className="mt-10 flex flex-wrap gap-4">
            <Button href="/dashboard">Review latest analysis</Button>
            <Button href="/insights" variant="outline">See benchmark guidance</Button>
          </div>
        </div>
      </div>
    </main>
  );
}
