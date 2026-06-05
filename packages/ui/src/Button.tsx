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
