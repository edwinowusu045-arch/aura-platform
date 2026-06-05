#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: '$1' is required but not installed." >&2
    exit 1
  fi
}

require_command git
require_command node
require_command npm
require_command npx

if [ ! -d .git ]; then
  git init
fi

mkdir -p apps/web apps/web/app apps/web/app/auth/login apps/web/app/auth/register apps/web/app/insights apps/web/app/dashboard apps/web/app/what-if apps/web/app/launchpad apps/web/app/plans apps/web/app/legal apps/web/app/admin apps/web/app/api/auth apps/web/app/api/analysis apps/web/components apps/mobile packages/core packages/ui packages/api packages/api/src packages/core/src packages/ui/src

write_file() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  cat > "$path" <<'EOF'
$2
EOF
}

cat > package.json <<'EOF'
{
  "name": "aura-platform",
  "private": true,
  "workspaces": [
    "apps/web",
    "apps/mobile",
    "packages/core",
    "packages/ui",
    "packages/api"
  ],
  "scripts": {
    "dev:web": "npm --workspace apps/web run dev",
    "dev:mobile": "npm --workspace apps/mobile run start"
  }
}
EOF

cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "lib": ["dom", "dom.iterable", "es2020"],
    "jsx": "preserve",
    "allowJs": false,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@aura/core": ["packages/core/src"],
      "@aura/ui": ["packages/ui/src"],
      "@aura/api": ["packages/api/src"]
    },
    "incremental": true,
    "types": ["node"]
  },
  "include": ["apps/**/*", "packages/**/*"],
  "exclude": ["node_modules"]
}
EOF

cat > .gitignore <<'EOF'
node_modules
.next
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.DS_Store
dist
.expo
web-build
EOF

cat > README.md <<'EOF'
# AURA v2 Platform

This repository contains the AURA unified AI business intelligence monorepo.

- apps/web: Next.js 14 App Router web experience
- apps/mobile: Expo React Native mobile app
- packages/core: shared business types and logic
- packages/ui: shared design system components
- packages/api: shared auth and analytics simulation
EOF

cat > apps/web/package.json <<'EOF'
{
  "name": "aura-web",
  "private": true,
  "version": "0.1.0",
  "scripts": {
    "dev": "next dev -p 3000",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "@aura/api": "file:../../packages/api",
    "@aura/core": "file:../../packages/core",
    "@aura/ui": "file:../../packages/ui",
    "bcryptjs": "^2.4.3",
    "cmdk": "^1.0.0",
    "framer-motion": "^11.0.0",
    "jsonwebtoken": "^9.0.0",
    "papaparse": "^5.4.1",
    "next": "14.2.17",
    "next-themes": "^0.4.6",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "recharts": "^2.9.0",
    "sonner": "^0.6.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8.4.36",
    "autoprefixer": "^10.4.20",
    "zod": "^3.23.0",
    "helmet": "^7.0.0"
  },
  "devDependencies": {
    "@types/bcryptjs": "^2.4.2",
    "@types/jsonwebtoken": "^9.0.2",
    "@types/node": "^20.14.0",
    "@types/react": "^18.3.3",
    "@types/react-dom": "^18.3.0",
    "eslint": "^8.57.0",
    "eslint-config-next": "14.2.17",
    "typescript": "^5.6.2"
  }
}
EOF

cat > apps/web/next.config.mjs <<'EOF'
import path from 'path';

const nextConfig = {
  reactStrictMode: true,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.unsplash.com'
      }
    ]
  },
  experimental: {
    appDir: true
  },
  webpack(config) {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@aura/core': path.resolve(__dirname, '../../packages/core/src'),
      '@aura/ui': path.resolve(__dirname, '../../packages/ui/src'),
      '@aura/api': path.resolve(__dirname, '../../packages/api/src')
    };
    return config;
  }
};

export default nextConfig;
EOF

cat > apps/web/tsconfig.json <<'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "jsx": "preserve"
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
EOF

cat > apps/web/next-env.d.ts <<'EOF'
/// <reference types="next" />
/// <reference types="next/image-types/global" />

// NOTE: This file should not be edited
EOF

cat > apps/web/tailwind.config.ts <<'EOF'
import type { Config } from 'tailwindcss';

export default {
  content: ['./app/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        aura: {
          charcoal: '#0A0A0A',
          gold: '#C9A96E',
          euBlue: '#003399',
          darkGray: '#1F2937',
          lite: '#E8F1FF',
          royal: '#0D1B5A',
          platinum: '#F8F8F8'
        }
      },
      boxShadow: {
        card: '0 24px 80px rgba(0,0,0,0.12)'
      },
      fontFamily: {
        heading: ['var(--font-playfair)', 'serif'],
        body: ['var(--font-inter)', 'sans-serif']
      }
    }
  },
  plugins: []
} satisfies Config;
EOF

cat > apps/web/postcss.config.js <<'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
EOF

cat > apps/web/app/layout.tsx <<'EOF'
import type { Metadata } from 'next';
import { Inter, Playfair_Display } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' });
const playfair = Playfair_Display({ subsets: ['latin'], variable: '--font-playfair', weight: ['400', '600', '700', '800'] });

export const metadata: Metadata = {
  title: 'AURA v2 | AI Business Intelligence',
  description: 'Institutional-grade AI business intelligence for finance, research, and enterprise teams.'
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className="scroll-smooth">
      <body className={`${inter.variable} ${playfair.variable} bg-white text-[#1F2937]`}>{children}</body>
    </html>
  );
}
EOF

cat > apps/web/app/globals.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  color-scheme: light;
  font-family: var(--font-inter), system-ui, sans-serif;
  background: #ffffff;
  color: #1f2937;
}

html {
  scroll-behavior: smooth;
}

body {
  margin: 0;
  min-height: 100vh;
  background: #ffffff;
}

* {
  box-sizing: border-box;
}

button,
input,
textarea,
select {
  font: inherit;
}

img {
  max-width: 100%;
  display: block;
}

section {
  position: relative;
}

.heading-shadow {
  text-shadow: 0 18px 60px rgba(0, 0, 0, 0.18);
}

.hero-fade {
  animation: hero-fade 1.4s ease forwards;
}

@keyframes hero-fade {
  from { opacity: 0; transform: translateY(18px); }
  to { opacity: 1; transform: translateY(0); }
}

.card-hover:hover {
  transform: translateY(-6px);
}

.card-hover {
  transition: transform 0.24s ease;
}

.fade-in-up {
  animation: fadeInUp 1s ease both;
}

@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(18px); }
  to { opacity: 1; transform: translateY(0); }
}
EOF

cat > apps/web/app/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/dashboard/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/auth/login/page.tsx <<'EOF'
'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from '@aura/ui';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError('');
    const response = await fetch('/api/auth', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ type: 'login', email, password })
    });
    const result = await response.json();
    if (!response.ok) {
      setError(result.message || 'Unable to sign in');
      return;
    }
    localStorage.setItem('aura_token', result.token);
    localStorage.setItem('aura_user', JSON.stringify(result.user));
    router.push(result.user.email === 'owusueddie1@gmail.com' ? '/admin' : '/dashboard');
  }

  return (
    <main className="min-h-screen bg-[#F8F8F8] px-6 py-16 sm:px-10 lg:px-16">
      <div className="mx-auto max-w-2xl rounded-[32px] bg-white p-10 shadow-card">
        <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">Sign in</p>
        <h1 className="mt-4 text-4xl font-semibold text-[#0A0A0A]">Welcome back to AURA</h1>
        <form onSubmit={handleSubmit} className="mt-10 space-y-6">
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Email</span>
            <input value={email} onChange={(event) => setEmail(event.target.value)} type="email" required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          <label className="block">
            <span className="text-sm font-medium text-[#1F2937]">Password</span>
            <input value={password} onChange={(event) => setPassword(event.target.value)} type="password" required className="mt-3 w-full rounded-3xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-[#C9A96E]" />
          </label>
          {error ? <p className="text-sm text-red-600">{error}</p> : null}
          <Button type="submit" variant="solid" className="w-full">Continue</Button>
        </form>
        <p className="mt-6 text-sm text-slate-500">New to AURA? <a href="/auth/register" className="font-semibold text-[#003399]">Create an account</a></p>
      </div>
    </main>
  );
}
EOF

cat > apps/web/app/auth/register/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/insights/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/what-if/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/launchpad/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/plans/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/legal/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/admin/page.tsx <<'EOF'
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
EOF

cat > apps/web/app/api/auth/route.ts <<'EOF'
import { NextRequest, NextResponse } from 'next/server';
import { authenticateUser, registerUser } from '@aura/api';

export async function POST(request: NextRequest) {
  const body = await request.json();
  if (body.type === 'register') {
    const result = await registerUser(body);
    return NextResponse.json(result, { status: result.success ? 200 : 400 });
  }

  if (body.type === 'login') {
    const result = await authenticateUser(body);
    return NextResponse.json(result, { status: result.success ? 200 : 401 });
  }

  return NextResponse.json({ success: false, message: 'Invalid auth request' }, { status: 400 });
}
EOF

cat > apps/web/app/api/analysis/route.ts <<'EOF'
import { NextResponse } from 'next/server';
import { createSimulatedAnalysis } from '@aura/api';

export async function GET() {
  return NextResponse.json({ success: true, analysis: createSimulatedAnalysis() });
}
EOF

cat > apps/web/components/SectionHeading.tsx <<'EOF'
export function SectionHeading({ title, description }: { title: string; description: string }) {
  return (
    <div className="space-y-3">
      <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">{title}</p>
      <p className="text-3xl font-semibold text-[#0A0A0A]">{description}</p>
    </div>
  );
}
EOF

cat > apps/mobile/package.json <<'EOF'
{
  "name": "aura-mobile",
  "private": true,
  "version": "0.1.0",
  "main": "node_modules/expo/AppEntry.js",
  "scripts": {
    "start": "expo start --tunnel",
    "web": "expo start --web"
  },
  "dependencies": {
    "@react-native-async-storage/async-storage": "^1.19.4",
    "@react-navigation/native": "^6.1.7",
    "@react-navigation/native-stack": "^6.9.14",
    "expo": "~49.0.0",
    "expo-notifications": "~0.24.0",
    "expo-status-bar": "~1.4.4",
    "nativewind": "^4.2.5",
    "papaparse": "^5.4.1",
    "react": "18.2.0",
    "react-native": "0.72.0",
    "react-native-gesture-handler": "^2.12.0",
    "react-native-safe-area-context": "^4.9.4",
    "react-native-screens": "^3.22.0",
    "zod": "^3.23.0"
  },
  "devDependencies": {
    "typescript": "^5.6.2",
    "@types/react": "^18.3.3",
    "@types/react-native": "^0.72.0"
  },
  "expo": {
    "name": "AURA Mobile",
    "slug": "aura-mobile",
    "sdkVersion": "49.0.0",
    "platforms": ["ios", "android", "web"],
    "assetBundlePatterns": ["**/*"],
    "plugins": ["nativewind/babel"]
  }
}
EOF

cat > apps/mobile/tsconfig.json <<'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "jsx": "react-jsx",
    "noEmit": true
  },
  "include": ["**/*.ts", "**/*.tsx"]
}
EOF

cat > apps/mobile/babel.config.js <<'EOF'
module.exports = function (api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    plugins: ['nativewind/babel']
  };
};
EOF

cat > apps/mobile/tailwind.config.js <<'EOF'
module.exports = {
  content: ['./**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        aura: {
          charcoal: '#0A0A0A',
          gold: '#C9A96E',
          euBlue: '#003399',
          darkGray: '#1F2937',
          lite: '#E8F1FF',
          royal: '#0D1B5A',
          platinum: '#F8F8F8'
        }
      },
      boxShadow: {
        card: '0 28px 70px rgba(0,0,0,0.15)'
      }
    }
  },
  plugins: []
};
EOF

cat > apps/mobile/App.tsx <<'EOF'
import { useEffect, useMemo, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Pressable, ScrollView, StatusBar, Text, TextInput, View } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Notifications from 'expo-notifications';

const Stack = createNativeStackNavigator();

function Card({ children }: { children: React.ReactNode }) {
  return <View className="rounded-3xl bg-white p-6 shadow-card">{children}</View>;
}

function HomeScreen({ navigation }: any) {
  const [message, setMessage] = useState('Deliver premium confidence with AURA.');

  useEffect(() => {
    Notifications.scheduleNotificationAsync({
      content: { title: 'AURA Mobile', body: 'Your weekly analysis is ready.' },
      trigger: { seconds: 10 }
    });
  }, []);

  return (
    <ScrollView className="flex-1 bg-[#0A0A0A] p-6">
      <StatusBar style="light" />
      <Text className="mt-10 text-4xl font-semibold text-white">AURA Mobile</Text>
      <Text className="mt-4 text-lg leading-8 text-slate-300">Institutional AI intelligence for on-demand business confidence.</Text>
      <View className="mt-10 space-y-4">
        <Pressable onPress={() => navigation.navigate('Dashboard')} className="rounded-full bg-[#C9A96E] px-6 py-4">
          <Text className="text-center text-sm font-semibold uppercase text-[#0A0A0A]">Open Dashboard</Text>
        </Pressable>
        <Pressable onPress={() => navigation.navigate('Insights')} className="rounded-full border border-white/20 px-6 py-4">
          <Text className="text-center text-sm font-semibold text-white">View Insights</Text>
        </Pressable>
        <Pressable onPress={() => navigation.navigate('Launchpad')} className="rounded-full border border-[#C9A96E] px-6 py-4">
          <Text className="text-center text-sm font-semibold text-[#C9A96E]">Run Launchpad</Text>
        </Pressable>
      </View>
      <Card>
        <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Live pulse</Text>
        <Text className="mt-3 text-3xl font-semibold text-[#0A0A0A]">{message}</Text>
        <Text className="mt-4 text-sm leading-7 text-[#4B5563]">Monitor plan signals, risk alerts and expert commentary in a single mobile view.</Text>
      </Card>
    </ScrollView>
  );
}

function DashboardScreen() {
  const [score] = useState(94);
  const cards = useMemo(
    () => [
      { label: 'Health Score', value: `${score}%` },
      { label: 'Analyses', value: '32 active' },
      { label: 'Forecast', value: '+18%' }
    ],
    [score]
  );

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Dashboard</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Investor and institution controls at your fingertips.</Text>
      <View className="mt-8 space-y-4">
        {cards.map((card) => (
          <Card key={card.label}>
            <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">{card.label}</Text>
            <Text className="mt-3 text-2xl font-semibold text-[#0A0A0A]">{card.value}</Text>
          </Card>
        ))}
      </View>
    </ScrollView>
  );
}

function InsightsScreen() {
  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Insights</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Overview, revenue, risk and benchmark signals for your organization.</Text>
      <View className="mt-8 space-y-4">
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Market outlook</Text>
          <Text className="mt-3 text-lg font-semibold text-[#0A0A0A]">Institutional trust continues to drive premium asset allocation.</Text>
        </Card>
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Risk snapshot</Text>
          <Text className="mt-3 text-lg font-semibold text-[#0A0A0A]">Anomaly detection and compliance signals are stable.</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

function LaunchpadScreen() {
  const [idea, setIdea] = useState('');
  const [score, setScore] = useState(78);

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Launchpad</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Submit a description and review confidence, strengths, gaps and recommendations.</Text>
      <View className="mt-8 space-y-4">
        <TextInput value={idea} onChangeText={setIdea} placeholder="Describe your pitch or idea" placeholderTextColor="#94A3B8" className="rounded-3xl border border-slate-300 bg-white px-4 py-4 text-base text-[#0A0A0A]" />
        <Pressable onPress={() => setScore((prev) => Math.min(100, prev + 3))} className="rounded-full bg-[#003399] px-6 py-4">
          <Text className="text-center text-sm font-semibold text-white">Evaluate confidence</Text>
        </Pressable>
        <Card>
          <Text className="text-sm uppercase tracking-[0.3em] text-[#003399]">Confidence score</Text>
          <Text className="mt-3 text-4xl font-semibold text-[#0A0A0A]">{score}%</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

function PlansScreen() {
  const tiers = [
    { title: 'Lite', subtitle: 'Free, 1/mo', color: '#E8F1FF' },
    { title: 'Pro', subtitle: '$79/mo', color: '#0D1B5A' },
    { title: 'Enterprise+', subtitle: '$2,499/mo', color: '#C9A96E' }
  ];

  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Plans</Text>
      <View className="mt-8 space-y-4">
        {tiers.map((tier) => (
          <View key={tier.title} className="rounded-3xl border border-slate-200 bg-white p-6">
            <Text className="text-xl font-semibold text-[#0A0A0A]">{tier.title}</Text>
            <Text className="mt-2 text-sm text-[#4B5563]">{tier.subtitle}</Text>
          </View>
        ))}
      </View>
    </ScrollView>
  );
}

function ProfileScreen() {
  return (
    <ScrollView className="flex-1 bg-[#F8F8F8] p-6">
      <Text className="text-3xl font-semibold text-[#0A0A0A]">Profile lenses</Text>
      <Text className="mt-3 text-sm text-[#4B5563]">Student, Financial Institution, Advisor and Investor views to keep your workspace aligned.</Text>
      <View className="mt-8 space-y-4">
        <Card>
          <Text className="text-lg font-semibold text-[#0A0A0A]">Student</Text>
          <Text className="mt-2 text-sm text-[#4B5563]">Study planner, flashcards, citation helper and academic integrity reminders.</Text>
        </Card>
        <Card>
          <Text className="text-lg font-semibold text-[#0A0A0A]">Financial Institution</Text>
          <Text className="mt-2 text-sm text-[#4B5563]">Regulatory scanner, stress test, fraud monitoring and SWIFT overview.</Text>
        </Card>
      </View>
    </ScrollView>
  );
}

export default function App() {
  useEffect(() => {
    Notifications.setNotificationHandler({
      handleNotification: async () => ({ shouldShowAlert: true, shouldPlaySound: false, shouldSetBadge: false })
    });
  }, []);

  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{ headerStyle: { backgroundColor: '#0A0A0A' }, headerTintColor: '#FFFFFF' }}>
        <Stack.Screen name="Home" component={HomeScreen} options={{ title: 'AURA' }} />
        <Stack.Screen name="Dashboard" component={DashboardScreen} />
        <Stack.Screen name="Insights" component={InsightsScreen} />
        <Stack.Screen name="Launchpad" component={LaunchpadScreen} />
        <Stack.Screen name="Plans" component={PlansScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
EOF

cat > packages/core/package.json <<'EOF'
{
  "name": "@aura/core",
  "version": "0.1.0",
  "private": true,
  "main": "src/index.ts",
  "types": "src/index.ts"
}
EOF

cat > packages/core/src/index.ts <<'EOF'
export interface UserProfile {
  name: string;
  email: string;
  organization: string;
  role: 'user' | 'admin';
}

export interface PlanDefinition {
  name: string;
  price: string;
  description: string;
}

export const defaultPlans: PlanDefinition[] = [
  { name: 'Starter', price: '7-day trial', description: '5 analyses with guided onboarding.' },
  { name: 'Lite', price: 'Free', description: '1 analysis per month for research workflows.' },
  { name: 'Pro', price: '$79/mo', description: 'Unlimited analytics, scenario planning and dashboards.' },
  { name: 'Enterprise', price: '$299/mo', description: 'SSO, audit logs, RBAC, compliance workflows.' },
  { name: 'Enterprise+', price: '$2,499/mo', description: 'AI Guardian, dedicated security and growth engine.' }
];
EOF

cat > packages/ui/package.json <<'EOF'
{
  "name": "@aura/ui",
  "version": "0.1.0",
  "private": true,
  "main": "src/index.ts",
  "types": "src/index.ts",
  "exports": {
    ".": {
      "import": "./src/index.ts",
      "require": "./src/index.ts"
    }
  }
}
EOF

cat > packages/ui/src/Button.tsx <<'EOF'
import Link from 'next/link';

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  href?: string;
  variant?: 'solid' | 'outline';
  className?: string;
}

export function Button({ href, variant = 'solid', className = '', children, ...props }: ButtonProps) {
  const base = 'inline-flex items-center justify-center rounded-full px-6 py-3 text-sm font-semibold transition focus:outline-none focus:ring-2 focus:ring-[#C9A96E]';
  const solid = 'bg-[#C9A96E] text-[#0A0A0A] shadow-lg shadow-[#C9A96E]/20 hover:scale-[1.02]';
  const outline = 'border border-[#C9A96E] text-[#0A0A0A] bg-white hover:bg-[#C9A96E]/10';

  const classes = `${base} ${variant === 'solid' ? solid : outline} ${className}`;

  if (href) {
    return (
      <Link href={href} className={classes} {...props}>
        {children}
      </Link>
    );
  }

  return (
    <button className={classes} {...props}>
      {children}
    </button>
  );
}
EOF

cat > packages/ui/src/Card.tsx <<'EOF'
interface CardProps {
  className?: string;
  children: React.ReactNode;
}

export function Card({ className = '', children }: CardProps) {
  return <div className={`rounded-[32px] bg-white shadow-card ${className}`}>{children}</div>;
}
EOF

cat > packages/ui/src/index.ts <<'EOF'
export * from './Button';
export * from './Card';
EOF

cat > packages/api/package.json <<'EOF'
{
  "name": "@aura/api",
  "version": "0.1.0",
  "private": true,
  "main": "src/index.ts",
  "types": "src/index.ts",
  "dependencies": {
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.0",
    "papaparse": "^5.4.1",
    "zod": "^3.23.0",
    "helmet": "^7.0.0"
  }
}
EOF

cat > packages/api/src/auth.ts <<'EOF'
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { z } from 'zod';

const jwtSecret = 'aura-secret-2026';

const registerSchema = z.object({
  type: z.literal('register'),
  name: z.string().min(2),
  email: z.string().email(),
  password: z.string().min(6),
  organization: z.string().min(2)
});

const loginSchema = z.object({
  type: z.literal('login'),
  email: z.string().email(),
  password: z.string().min(6)
});

const users: Record<string, { name: string; email: string; passwordHash: string; organization: string; role: 'user' | 'admin' }> = {
  'owusueddie1@gmail.com': {
    name: 'Eddie Owusu',
    email: 'owusueddie1@gmail.com',
    passwordHash: bcrypt.hashSync('pintogee12'),
    organization: 'AURA Executive',
    role: 'admin'
  }
};

export async function registerUser(data: unknown) {
  const parsed = registerSchema.safeParse(data);
  if (!parsed.success) {
    return { success: false, message: 'Invalid registration data' };
  }

  const { email, name, password, organization } = parsed.data;
  if (users[email]) {
    return { success: false, message: 'Account already exists' };
  }

  const passwordHash = await bcrypt.hash(password, 10);
  users[email] = { name, email, organization, passwordHash, role: 'user' };
  const token = jwt.sign({ email, role: 'user', name }, jwtSecret, { expiresIn: '30d' });

  return { success: true, token, user: { name, email, organization, role: 'user' } };
}

export async function authenticateUser(data: unknown) {
  const parsed = loginSchema.safeParse(data);
  if (!parsed.success) {
    return { success: false, message: 'Invalid login data' };
  }

  const { email, password } = parsed.data;
  const user = users[email];
  if (!user) {
    return { success: false, message: 'Invalid credentials' };
  }

  const matched = await bcrypt.compare(password, user.passwordHash);
  if (!matched) {
    return { success: false, message: 'Invalid credentials' };
  }

  const token = jwt.sign({ email: user.email, role: user.role, name: user.name }, jwtSecret, { expiresIn: '30d' });
  return { success: true, token, user: { name: user.name, email: user.email, organization: user.organization, role: user.role } };
}

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, jwtSecret);
  } catch {
    return null;
  }
}
EOF

cat > packages/api/src/analysis.ts <<'EOF'
export function createSimulatedAnalysis() {
  return {
    yearlyProjection: '$182.4M',
    grossMargin: '63.8%',
    topRisk: 'Customer churn signal',
    expertPanel: 'Leverage revenue velocity and compliance controls to protect EBITDA.',
    sections: [
      { label: 'Revenue', value: '+18%', color: '#0D1B5A' },
      { label: 'Expenses', value: '-6%', color: '#C9A96E' },
      { label: 'Benchmarks', value: 'Top 12%', color: '#003399' }
    ]
  };
}
EOF

cat > packages/api/src/index.ts <<'EOF'
export * from './auth';
export * from './analysis';
EOF

cat > packages/ui/src/index.ts <<'EOF'
export * from './Button';
export * from './Card';
EOF

cat > packages/core/src/index.ts <<'EOF'
export interface AuraPlan {
  name: string;
  price: string;
  description: string;
}

export const auraPlans: AuraPlan[] = [
  { name: 'Starter', price: '7-day trial', description: '5 analyses with guided onboarding.' },
  { name: 'Lite', price: 'Free', description: '1 analysis per month.' },
  { name: 'Pro', price: '$79/mo', description: 'Unlimited analysis and reporting.' },
  { name: 'Enterprise', price: '$299/mo', description: 'SSO, audit logs, compliance.' },
  { name: 'Enterprise+', price: '$2,499/mo', description: 'AI Guardian and premium support.' }
];
EOF

cat > apps/mobile/README.md <<'EOF'
# AURA Mobile

Run the mobile app with:

npm --workspace apps/mobile start
EOF

npm install

if [ -n "$(git status --porcelain)" ]; then
  git add .
  git commit -m "Initialize AURA v2 platform monorepo"
fi

git push origin main || true

echo "AURA v2 platform scaffold created. Starting Next.js web server on port 5000..."
cd apps/web
npm run dev -- --hostname 0.0.0.0 --port 5000
