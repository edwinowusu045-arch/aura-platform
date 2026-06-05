import { Card } from '@aura/ui';
import Link from 'next/link';

const tabs = ['Overview', 'Revenue', 'Expenses', 'Benchmarks', 'Risk', 'Cohort', 'Heatmap'];
const recommendations = [
  'Refine forecast cadence with confidence-aware margins.',
  'Align regulatory scan output to upcoming reporting cycles.',
  'Prioritize anomaly flags with enterprise risk thresholds.'
];

export default function InsightsPage() {
  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 text-[#0A0A0A] sm:px-10 lg:px-16">
      <div className="mx-auto max-w-6xl space-y-10">
        <div className="rounded-[40px] bg-white p-10 shadow-card">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
            <div>
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">AURA Insights</p>
              <h1 className="mt-4 text-4xl font-semibold">Multi-tab insight views for smarter decisions</h1>
            </div>
            <div className="flex flex-wrap gap-3">
              {tabs.map((tab) => (
                <span key={tab} className="rounded-full border border-slate-300 bg-slate-100 px-4 py-2 text-sm text-[#374151]">{tab}</span>
              ))}
            </div>
          </div>
          <div className="mt-10 grid gap-6 lg:grid-cols-3">
            <Card className="rounded-[32px] bg-[#111111] p-8 text-white shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Forecast chart</p>
              <p className="mt-4 text-3xl font-semibold">Revenue momentum</p>
            </Card>
            <Card className="rounded-[32px] p-8 shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">KPI snapshot</p>
              <ul className="mt-4 space-y-3 text-sm text-[#4B5563]">
                <li>Pipeline velocity +27%</li>
                <li>Burn ratio 0.82</li>
                <li>Forecast confidence 93%</li>
              </ul>
            </Card>
            <Card className="rounded-[32px] p-8 shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Expert review</p>
              <p className="mt-4 text-sm leading-7 text-[#4B5563]">AURA’s advisory panel flags the strongest revenue signals and top risk vectors for your executive summary.</p>
            </Card>
          </div>
        </div>
        <div className="grid gap-6 lg:grid-cols-3">
          {recommendations.map((text) => (
            <Card key={text} className="rounded-[32px] p-8 shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Recommendation</p>
              <p className="mt-4 text-lg font-semibold text-[#0A0A0A]">{text}</p>
            </Card>
          ))}
        </div>
        <div className="rounded-[32px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <h2 className="text-2xl font-semibold">Decision matrix</h2>
          <p className="mt-4 text-sm leading-7 text-slate-300">Simulated risk / reward for enterprise controls, compliance, and portfolio allocation.</p>
          <div className="mt-8 grid gap-6 md:grid-cols-2">
            <div className="rounded-3xl bg-[#111111] p-6">
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Risk</p>
              <ul className="mt-5 space-y-3 text-sm text-slate-300">
                <li>Regulatory drift</li>
                <li>Operational resilience</li>
                <li>Third-party breach</li>
              </ul>
            </div>
            <div className="rounded-3xl bg-[#111111] p-6">
              <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Recommendation</p>
              <ul className="mt-5 space-y-3 text-sm text-slate-300">
                <li>Increase SSO adoption</li>
                <li>Lock forecast approvals</li>
                <li>Audit analyst workflows</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
