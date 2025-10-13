import React from 'react';
import { AppHeader } from '@/components/AppHeader';
import { AppNav } from '@/components/AppNav';
import { RoutesRoot } from '@/routes';

export default function App() {
  return (
    <div className="min-h-svh bg-bg text-text">
      <AppHeader />
      <main className="max-w-screen-md mx-auto p-4 pb-20">
        <RoutesRoot />
      </main>
      <AppNav />
    </div>
  );
}
