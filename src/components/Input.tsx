import { InputHTMLAttributes } from 'react'

export default function Input(props: InputHTMLAttributes<HTMLInputElement>) {
  return (
    <input
      {...props}
      className={`w-full px-4 py-2 rounded-xl bg-gray-800 border border-gray-700 text-zinc-200 placeholder-zinc-500 shadow-inner focus:outline-none focus:ring-2 focus:ring-blue-600 focus:border-blue-500 transition ${props.className ?? ''}`}
    />
  )
} 