export function SectionHeading({ title, description }: { title: string; description: string }) {
  return (
    <div className="space-y-3">
      <p className="text-sm uppercase tracking-[0.3em] text-[#C9A96E]">{title}</p>
      <p className="text-3xl font-semibold text-[#0A0A0A]">{description}</p>
    </div>
  );
}
