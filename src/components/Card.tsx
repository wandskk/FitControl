import { ReactNode } from 'react'

export default function Card({ children, className = '' }: { children: ReactNode, className?: string }) {
  return (
    <div className={`bg-gray-900 border border-gray-800 rounded-3xl shadow-[0_4px_32px_0_rgba(0,0,0,0.45),0_1.5px_4px_0_rgba(30,64,175,0.10)] ${className}`}>
      {children}
    </div>
  )
} 