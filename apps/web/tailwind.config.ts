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
