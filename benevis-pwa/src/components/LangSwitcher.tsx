import React from 'react';

export function LangSwitcher() {
  function toggleLang() {
    const lang = document.documentElement.lang || 'fa';
    const next = lang === 'fa' ? 'en' : 'fa';
    document.documentElement.lang = next;
    document.documentElement.dir = next === 'fa' ? 'rtl' : 'ltr';
  }
  return <button onClick={toggleLang} className="px-2 py-1 glass">FA/EN</button>;
}
