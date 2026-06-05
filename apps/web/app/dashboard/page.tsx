'use client';

import { useEffect, useMemo, useState } from 'react';
import { Area, AreaChart, ResponsiveContainer } from 'recharts';
import { Button, Card } from '@aura/ui';

const healthScore = 92;
const cards = [
  { label: 'Streak', value: '14 days', accent: 'lite' },
  { label: 'Badges', value: '6 earned', accent: 'royal' },
  { label: 'Analyses', value: '42 active', accent: 'platinum' },
  { label: 'Goal Progress', value: '78%', accent: 'gold' }
];

const chartData = [
  { month: 'Jan', value: 120 },
  { month: 'Feb', value: 150 },
  { month: 'Mar', value: 170 },
  { month: 'Apr', value: 180 },
  { month: 'May', value: 220 },
  { month: 'Jun', value: 240 }
];

export default function DashboardPage() {
  const [count, setCount] = useState(0);
  const [plan] = useState('Enterprise+');

  useEffect(() => {
    let current = 0;
    const target = 92;
    const step = () => {
      if (current < target) {
        current += 2;
        setCount(current);
        requestAnimationFrame(step);
      }
    };
    step();
  }, []);

  const quickActions = useMemo(
    () => [
      { label: 'Upload data room', href: '/dashboard' },
      { label: 'Run anomaly scan', href: '/what-if' },
      { label: 'Review governance', href: '/legal' }
    ],
    []
  );

  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-12 text-[#0A0A0A] sm:px-10 lg:px-16">
      <div className="mx-auto max-w-6xl space-y-10">
        <div className="rounded-[40px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            <div>
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Welcome back</p>
              <h1 className="mt-4 text-4xl font-semibold">Aura Executive Dashboard</h1>
              <p className="mt-3 max-w-2xl leading-7 text-slate-300">Your centralized command center for revenue, risk and AI governance.</p>
            </div>
            <div className="rounded-3xl border border-white/10 bg-white/10 px-8 py-6 text-center">
              <p className="text-sm uppercase tracking-[0.3em] text-slate-300">Health Score</p>
              <p className="mt-4 text-5xl font-semibold">{count}%</p>
            </div>
          </div>
        </div>

        <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
          {cards.map((card) => (
            <Card key={card.label} className="rounded-[32px] p-8 shadow-card card-hover">
              <p className="text-sm uppercase tracking-[0.3em] text-slate-500">{card.label}</p>
              <p className="mt-4 text-3xl font-semibold">{card.value}</p>
            </Card>
          ))}
        </div>

        <div className="grid gap-6 lg:grid-cols-3">
          <Card className="rounded-[32px] bg-white p-8 shadow-card">
            <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Plan</p>
            <p className="mt-4 text-3xl font-semibold">{plan}</p>
            <p className="mt-3 text-sm leading-7 text-slate-600">Royal sapphire and platinum controls for enterprise clients with full AI Guardian protection.</p>
          </Card>
          <Card className="rounded-[32px] bg-white p-8 shadow-card">
            <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Quick actions</p>
            <div className="mt-6 flex flex-col gap-3">
              {quickActions.map((action) => (
                <Button key={action.label} href={action.href} variant="outline" className="w-full text-left">{action.label}</Button>
              ))}
            </div>
          </Card>
          <Card className="rounded-[32px] bg-white p-8 shadow-card">
            <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Yearly projection</p>
            <div className="mt-6 h-52">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData}>
                  <defs>
                    <linearGradient id="projection" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#C9A96E" stopOpacity={0.8} />
                      <stop offset="95%" stopColor="#C9A96E" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <Area type="monotone" dataKey="value" stroke="#C9A96E" fill="url(#projection)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </Card>
        </div>
      </div>
    </main>
  );
}
