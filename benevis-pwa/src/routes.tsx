import React, { useEffect, useState } from 'react';
import Onboarding from '@/features/onboarding/Onboarding';
import Dashboard from '@/features/dashboard/Dashboard';
import Journal from '@/features/journal/Journal';
import Habits from '@/features/habits/Habits';
import Settings from '@/features/settings/Settings';

function useHash(): string {
  const [hash, setHash] = useState(window.location.hash || '#/');
  useEffect(() => {
    const onHash = () => setHash(window.location.hash || '#/');
    window.addEventListener('hashchange', onHash);
    return () => window.removeEventListener('hashchange', onHash);
  }, []);
  return hash;
}

export function RoutesRoot() {
  const hash = useHash();
  switch (hash) {
    case '#/onboarding':
      return <Onboarding />;
    case '#/journal':
      return <Journal />;
    case '#/habits':
      return <Habits />;
    case '#/settings':
      return <Settings />;
    case '#/':
    default:
      return <Dashboard />;
  }
}
