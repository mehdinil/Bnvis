import React from 'react';

export function ThemeSwitcher() {
  function cycleTheme() {
    const themes = ['benevis', 'emerald', 'neomorph'] as const;
    const current = document.documentElement.getAttribute('data-theme') || 'benevis';
    const idx = themes.indexOf(current as any);
    const next = themes[(idx + 1) % themes.length];
    document.documentElement.setAttribute('data-theme', next);
  }
  function toggleMode() {
    const mode = document.documentElement.getAttribute('data-mode') || 'dark';
    document.documentElement.setAttribute('data-mode', mode === 'dark' ? 'light' : 'dark');
  }
  return (
    <div className="flex gap-1">
      <button onClick={toggleMode} className="px-2 py-1 glass">تیره/روشن</button>
      <button onClick={cycleTheme} className="px-2 py-1 glass">تم</button>
    </div>
  );
}
