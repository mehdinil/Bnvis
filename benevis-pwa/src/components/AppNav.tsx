import React from 'react';

export function AppNav() {
  const item = (href: string, label: string) => (
    <a href={href} className="px-3 py-2 rounded-md hover:bg-white/5">
      {label}
    </a>
  );
  return (
    <nav className="fixed bottom-0 inset-x-0 glass p-2">
      <div className="max-w-screen-md mx-auto flex items-center justify-around text-sm">
        {item('#/', 'خانه')}
        {item('#/habits', 'عادت‌ها')}
        {item('#/journal', 'یادداشت')}
        {item('#/settings', 'تنظیمات')}
      </div>
    </nav>
  );
}
