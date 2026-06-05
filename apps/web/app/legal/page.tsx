import Link from 'next/link';

const topics = [
  { title: 'Privacy', description: 'Protecting your data with enterprise controls and secure storage.' },
  { title: 'Terms', description: 'Trusted usage terms for customers, partners, and regulated institutions.' },
  { title: 'AI Ethics', description: 'Transparent AI governance, fairness reviews, and decision reporting.' },
  { title: 'Security', description: 'Warrant canary, data sovereignty promise, and audit-ready compliance.' }
];

export default function LegalPage() {
  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 text-[#0A0A0A] sm:px-10 lg:px-16">
      <div className="mx-auto max-w-6xl space-y-10">
        <div className="rounded-[40px] bg-white p-10 shadow-card">
          <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Legal & trust</p>
          <h1 className="mt-4 text-4xl font-semibold">Security and compliance designed for enterprise scale</h1>
          <p className="mt-4 max-w-2xl text-sm leading-7 text-[#4B5563]">AURA combines policy, security, and AI ethics into one trusted platform for regulated stakeholders.</p>
        </div>
        <div className="grid gap-6 lg:grid-cols-2">
          {topics.map((topic) => (
            <div key={topic.title} className="rounded-[32px] bg-white p-8 shadow-card">
              <p className="text-sm uppercase tracking-[0.3em] text-[#003399]">{topic.title}</p>
              <p className="mt-4 text-lg font-semibold text-[#0A0A0A]">{topic.title}</p>
              <p className="mt-3 text-sm leading-7 text-[#4B5563]">{topic.description}</p>
            </div>
          ))}
        </div>
        <div className="rounded-[32px] bg-[#0A0A0A] p-10 text-white shadow-card">
          <h2 className="text-3xl font-semibold">Cookie consent and AI disclaimer</h2>
          <p className="mt-4 max-w-3xl text-sm leading-7 text-slate-300">AURA uses cookies to personalize analytics and delivers AI guidance with guardrails, review logs, and compliance warnings.</p>
          <Link href="/" className="mt-6 inline-flex rounded-full border border-white/20 bg-white/5 px-6 py-3 text-sm font-semibold text-white transition hover:bg-white/10">Review trust commitments</Link>
        </div>
      </div>
    </main>
  );
}
