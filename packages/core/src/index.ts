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
