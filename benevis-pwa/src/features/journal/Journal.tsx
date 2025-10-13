import React, { useState } from 'react';

export default function Journal() {
  const [text, setText] = useState('');

  return (
    <div className="glass p-4 space-y-3">
      <h2 className="text-xl font-bold">دفترچه یادداشت</h2>
      <textarea
        value={text}
        onChange={(e) => setText(e.target.value)}
        placeholder="یادداشت‌های خود را اینجا بنویسید (Markdown پشتیبانی می‌شود)"
        className="w-full px-3 py-2 bg-card rounded-md"
        rows={15}
      />
      <button className="px-4 py-2 bg-accent text-white rounded-md">
        ذخیره
      </button>
    </div>
  );
}
