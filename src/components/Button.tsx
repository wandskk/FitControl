import { ButtonHTMLAttributes, ReactNode } from 'react'

export default function Button({ children, className = '', ...props }: ButtonHTMLAttributes<HTMLButtonElement> & { children: ReactNode }) {
  return (
    <button
      {...props}
      className={`w-full py-2 px-4 rounded-xl bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white font-semibold shadow-lg hover:brightness-110 active:scale-95 transition focus:outline-none focus:ring-2 focus:ring-blue-500 ${className}`}
    >
      {children}
    </button>
  )
} 