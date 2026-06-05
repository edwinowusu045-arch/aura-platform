interface CardProps {
  className?: string;
  children: React.ReactNode;
}

export function Card({ className = '', children }: CardProps) {
  return <div className={`rounded-[32px] bg-white shadow-card ${className}`}>{children}</div>;
}
