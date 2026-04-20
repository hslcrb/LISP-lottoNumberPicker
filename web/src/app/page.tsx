'use client';

import dynamic from 'next/dynamic';

const Terminal = dynamic(() => import('../components/Terminal'), {
  ssr: false,
  loading: () => <div className="w-full h-full bg-black flex items-center justify-center text-white font-mono">Initializing Terminal...</div>
});

export default function Home() {
  return (
    <main className="fixed inset-0 bg-black">
      <Terminal />
    </main>
  );
}
