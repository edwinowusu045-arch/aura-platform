import { Card } from '@aura/ui';

const plans = [
  { title: 'Starter', price: '7-day trial', features: ['5 analyses', 'Standard dashboards'] },
  { title: 'Lite', price: 'Free', features: ['1 analysis per month', 'Research lens'] },
  { title: 'Pro', price: '$79 / mo', features: ['Unlimited scenarios', 'Investor reporting'] },
  { title: 'Enterprise', price: '$299 / mo', features: ['SSO', 'Audit log', 'Compliance'] },
  { title: 'Enterprise+', price: '$2,499 / mo', features: ['AI Guardian', 'Dedicated support'] }
];

export default function PlansPage() {
  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 text-[#0A0A0A] sm:px-10 lg:px-16">
      <div className="mx-auto max-w-7xl space-y-10">
        <div className="rounded-[40px] bg-white p-10 shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Plans & pricing</p>
          <h1 className="mt-4 text-4xl font-semibold">Transparent pricing for every scale</h1>
          <p className="mt-4 max-w-2xl text-sm leading-7 text-[#4B5563]">Choose a plan that balances analyst velocity, institutional controls, and executive governance.</p>
        </div>
        <div className="grid gap-6 xl:grid-cols-5">
          {plans.map((plan) => (
            <Card key={plan.title} className="rounded-[32px] p-8 shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">{plan.title}</p>
              <p className="mt-4 text-3xl font-semibold">{plan.price}</p>
              <ul className="mt-6 space-y-3 text-sm text-[#4B5563]">
                {plan.features.map((feature) => (
                  <li key={feature}>• {feature}</li>
                ))}
              </ul>
            </Card>
          ))}
        </div>
        <div className="rounded-[32px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Promo</p>
          <h2 className="mt-4 text-3xl font-semibold">Use code AURALAUNCH for priority onboarding</h2>
          <p className="mt-3 text-sm leading-7 text-slate-300">Annual subscribers receive governance oversight, escrow option, and reserved War Room capacity.</p>
        </div>
      </div>
    </main>
  );
}
