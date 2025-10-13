import React from 'react';
import { ThemeSwitcher } from '@/components/ThemeSwitcher';
import { LangSwitcher } from '@/components/LangSwitcher';
import { InstallPrompt } from '@/components/InstallPrompt';

export function AppHeader() {
  return (
    <header className="sticky top-0 z-10 backdrop-blur-md glass p-3">
      <div className="max-w-screen-md mx-auto flex items-center justify-between gap-2">
        <h1 className="text-lg font-semibold">بِنویس</h1>
        <div className="flex items-center gap-2">
          <InstallPrompt />
          <LangSwitcher />
          <ThemeSwitcher />
        </div>
      </div>
    </header>
  );
}
