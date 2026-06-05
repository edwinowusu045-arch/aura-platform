import { Button, Card } from '@aura/ui';
import { motion } from 'framer-motion';
import Link from 'next/link';

const stats = [
  { label: 'Companies Empowered', value: '4,120+' },
  { label: 'Revenue Predicted', value: '$128M+' },
  { label: 'AI Analyses Run', value: '89,231+' }
];

const steps = [
  { title: 'Connect data', description: 'Upload revenue, finance and risk signals in one secure room.' },
  { title: 'Simulate scenarios', description: 'Explore what-if revenue and risk models with AI guidance.' },
  { title: 'Activate confidence', description: 'Deliver executive-ready plans with trust and transparency.' }
];

const benefits = [
  { title: 'Revenue Forecast', description: 'Predict growth using advanced anomaly detection and market signals.' },
  { title: 'Anomaly Detection', description: 'Surface hidden risk across finance, operations, and compliance.' },
  { title: 'Expert Panel', description: 'Access AI-curated recommendations with audit-ready reporting.' }
];

const plans = [
  { name: 'Starter', price: 'Free trial', detail: '7-day trial, 5 analyses', accent: 'bg-slate-50 text-slate-900' },
  { name: 'Lite', price: '$0 / mo', detail: 'Free, 1 analysis per month', accent: 'bg-slate-100 text-slate-900' },
  { name: 'Pro', price: '$79 / mo', detail: 'Unlimited forecasting and investor-ready reporting', accent: 'bg-[#0D1B5A] text-white' },
  { name: 'Enterprise', price: '$299 / mo', detail: 'SSO, audit log, security operations, compliance workflow', accent: 'bg-[#F8F8F8] text-[#1F2937]' },
  { name: 'Enterprise+', price: '$2,499 / mo', detail: 'Dedicated governance, AI Guardian, premium execution', accent: 'bg-[#C9A96E] text-[#0A0A0A]' }
];

const insights = [
  { title: 'Institutional planning in AI age', subtitle: 'How leading financial institutions trust AURA daily.', image: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=80' },
  { title: 'Revenue certainty through transparency', subtitle: 'Premium analytics for executive confidence.', image: 'https://images.unsplash.com/photo-1559526324-593bc073d938?auto=format&fit=crop&w=900&q=80' },
  { title: 'Risk controls built for enterprise', subtitle: 'Compliance first with audit-ready workflows.', image: 'https://images.unsplash.com/photo-1485217988980-11786ced9454?auto=format&fit=crop&w=900&q=80' }
];

export default function HomePage() {
  return (
    <main className="overflow-hidden">
      <section className="relative bg-[#0A0A0A] text-white">
        <div className="mx-auto max-w-7xl px-6 py-20 lg:px-8">
          <nav className="mb-10 flex items-center justify-between">
            <span className="text-lg font-semibold tracking-[0.24em] text-[#C9A96E]">AURA</span>
            <div className="flex gap-6 text-sm text-slate-200">
              <Link href="/dashboard">Dashboard</Link>
              <Link href="/insights">Insights</Link>
              <Link href="/plans">Plans</Link>
              <Link href="/legal">Legal</Link>
            </div>
          </nav>
          <div className="grid gap-16 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
            <motion.div initial={{ opacity: 0, y: 24 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.9 }}>
              <p className="mb-4 inline-flex rounded-full bg-[#C9A96E]/10 px-4 py-1 text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Premium confidence meets institutional trust</p>
              <h1 className="max-w-3xl text-5xl font-bold leading-tight tracking-tight text-white md:text-6xl">Your data has <span className="bg-gradient-to-r from-[#C9A96E] via-white to-[#C9A96E] bg-clip-text text-transparent">more to say</span>.</h1>
              <p className="mt-6 max-w-2xl text-lg leading-8 text-slate-300">A unified AI business intelligence ecosystem for enterprises, research institutions, advisors and investors.</p>
              <div className="mt-10 flex flex-col gap-4 sm:flex-row">
                <Button href="/auth/register" variant="solid">Start your free trial</Button>
                <Button href="/dashboard" variant="outline">See AURA in Action</Button>
              </div>
            </motion.div>
            <div className="relative rounded-[32px] border border-white/10 bg-white/5 p-8 shadow-card backdrop-blur-xl">
              <div className="mb-8 rounded-3xl bg-[#111111] p-8 text-white shadow-[0_30px_80px_rgba(0,0,0,0.3)]">
                <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Market pulse preview</p>
                <h2 className="mt-4 text-3xl font-semibold">Executive Summary</h2>
                <p className="mt-3 text-slate-300">A live executive command center for revenue projections, risk exposure, and AI governance.</p>
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                {stats.map((stat) => (
                  <div key={stat.label} className="rounded-3xl bg-slate-950/80 p-6 text-white shadow-card">
                    <p className="text-sm uppercase tracking-[0.3em] text-slate-400">{stat.label}</p>
                    <p className="mt-4 text-3xl font-semibold">{stat.value}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-white py-20">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="grid gap-12 lg:grid-cols-3">
            {steps.map((step, index) => (
              <Card key={step.title} className="p-8 shadow-card card-hover">
                <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-2xl bg-[#C9A96E]/10 text-[#C9A96E]">{index + 1}</div>
                <h3 className="text-xl font-semibold text-[#0A0A0A]">{step.title}</h3>
                <p className="mt-3 text-sm leading-7 text-[#374151]">{step.description}</p>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <section className="bg-slate-950 text-white py-20">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="mb-12 text-center">
            <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">What AURA gives you</p>
            <h2 className="mt-4 text-4xl font-semibold">Enterprise-grade AI capabilities designed for trust</h2>
          </div>
          <div className="grid gap-8 lg:grid-cols-3">
            {benefits.map((benefit) => (
              <Card key={benefit.title} className="rounded-[32px] bg-[#111111] p-8 shadow-card card-hover">
                <h3 className="text-2xl font-semibold text-white">{benefit.title}</h3>
                <p className="mt-4 text-slate-300">{benefit.description}</p>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <section className="bg-[#F8F8F8] py-20">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="grid gap-16 lg:grid-cols-2 lg:items-center">
            <div>
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">Insights & news</p>
              <h2 className="mt-4 text-4xl font-semibold text-[#0A0A0A]">Timely analysis for every stakeholder</h2>
              <p className="mt-4 max-w-xl text-lg leading-8 text-[#4B5563]">AURA combines active research, benchmark data and a live expert panel to keep executive teams aligned.</p>
            </div>
            <div className="grid gap-6 sm:grid-cols-2">
              {insights.map((item) => (
                <Card key={item.title} className="overflow-hidden rounded-3xl shadow-card">
                  <img src={item.image} alt={item.title} className="h-48 w-full object-cover" />
                  <div className="p-6 bg-white">
                    <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">News</p>
                    <h3 className="mt-3 text-xl font-semibold text-[#0A0A0A]">{item.title}</h3>
                    <p className="mt-2 text-sm leading-7 text-[#4B5563]">{item.subtitle}</p>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        </div>
      </section>

      <section className="bg-white py-20">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="mb-12 text-center">
            <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Plans preview</p>
            <h2 className="mt-4 text-4xl font-semibold text-[#0A0A0A]">Flexible access for every enterprise profile</h2>
          </div>
          <div className="grid gap-6 xl:grid-cols-5">
            {plans.map((plan) => (
              <Card key={plan.name} className="rounded-[32px] p-8 shadow-card card-hover">
                <div className={`mb-6 rounded-3xl p-6 ${plan.accent}`}>
                  <p className="text-sm uppercase tracking-[0.3em]">{plan.name}</p>
                  <p className="mt-6 text-3xl font-semibold">{plan.price}</p>
                </div>
                <p className="text-sm leading-7 text-[#4B5563]">{plan.detail}</p>
                <Button href="/plans" className="mt-6 w-full">Choose {plan.name}</Button>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <footer className="bg-[#0A0A0A] text-slate-300">
        <div className="mx-auto max-w-7xl px-6 py-16 lg:px-8">
          <div className="grid gap-12 sm:grid-cols-2 lg:grid-cols-4">
            <div>
              <p className="mb-4 text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Product</p>
              <div className="space-y-3 text-sm">
                <Link href="/dashboard">Dashboard</Link>
                <Link href="/insights">Insights</Link>
                <Link href="/what-if">What-if</Link>
              </div>
            </div>
            <div>
              <p className="mb-4 text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Company</p>
              <div className="space-y-3 text-sm">
                <Link href="/legal">Security</Link>
                <Link href="/legal">Trust</Link>
                <Link href="/legal">Careers</Link>
              </div>
            </div>
            <div>
              <p className="mb-4 text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Legal</p>
              <div className="space-y-3 text-sm">
                <Link href="/legal">Privacy</Link>
                <Link href="/legal">Terms</Link>
                <Link href="/legal">AI Ethics</Link>
              </div>
            </div>
            <div>
              <p className="mb-4 text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Contact</p>
              <div className="space-y-3 text-sm text-slate-400">
                <p>hello@aura.ai</p>
                <p>+1 (212) 555-0134</p>
                <p>Paris · London · New York</p>
              </div>
            </div>
          </div>
        </div>
      </footer>
    </main>
  );
}
