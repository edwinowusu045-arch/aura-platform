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
