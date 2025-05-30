export default function Logo() {
  return (
    <div className="flex items-center gap-2">
      <svg width="48" height="48" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <circle cx="16" cy="16" r="14" fill="#2563eb" fillOpacity="0.15" />
        <path d="M10 16c2-4 10-4 12 0" stroke="#2563eb" strokeWidth="2.5" strokeLinecap="round" />
        <circle cx="16" cy="16" r="6" stroke="#2563eb" strokeWidth="2" />
      </svg>
      <h1 className="text-xl font-bold text-blue-500 tracking-tight m-0">FitControl</h1>
    </div>
  )
} 