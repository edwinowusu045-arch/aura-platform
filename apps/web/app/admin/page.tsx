import { Card } from '@aura/ui';

const modules = [
  { title: 'Executive Command Center', description: 'War Room dashboards for governance, growth and data fidelity.' },
  { title: 'Customer Observatory', description: 'Customer outcomes, churn signals and elite account coverage.' },
  { title: 'Financial Nerve Center', description: 'Portfolio pulse, risk heatmaps and liquidity command.' },
  { title: 'AI Governance', description: 'Auto-Pilot oversight, policy tuning and decision audit trails.' },
  { title: 'Growth Engine', description: 'Pipeline velocity, expansion forecasts and capital readiness.' },
  { title: 'Futures Lab', description: 'Scenario stress, competitor intelligence and market signals.' }
];

export default function AdminPage() {
  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 text-[#0A0A0A] sm:px-10 lg:px-16">
      <div className="mx-auto max-w-7xl space-y-10">
        <div className="rounded-[40px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Hidden admin</p>
          <h1 className="mt-4 text-4xl font-semibold">AURA Executive Command Center</h1>
          <p className="mt-4 max-w-2xl text-sm leading-7 text-slate-300">A secluded subdomain experience for executive leaders, AI guardians and enterprise control teams.</p>
        </div>
        <div className="grid gap-6 lg:grid-cols-3">
          {modules.map((module) => (
            <Card key={module.title} className="rounded-[32px] p-8 shadow-card">
              <h2 className="text-xl font-semibold text-[#0A0A0A]">{module.title}</h2>
              <p className="mt-4 text-sm leading-7 text-[#4B5563]">{module.description}</p>
            </Card>
          ))}
        </div>
      </div>
    </main>
  );
}
