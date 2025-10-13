import React, { useEffect, useState } from 'react';
import { getUser, getHabits } from '@/data/storage';

export default function Dashboard() {
  const [user, setUser] = useState<any>(null);
  const [habits, setHabits] = useState<any[]>([]);

  useEffect(() => {
    (async () => {
      const u = await getUser();
      const h = await getHabits();
      setUser(u);
      setHabits(h);
    })();
  }, []);

  return (
    <div className="space-y-4">
      <div className="glass p-4">
        <h2 className="text-xl font-bold">سلام {user?.name || 'کاربر'}!</h2>
        <p className="text-sm mt-2">هدف: {user?.goal || 'تعریف نشده'}</p>
      </div>

      <div className="glass p-4">
        <h3 className="font-semibold mb-2">عادت‌های امروز</h3>
        {habits.length === 0 ? (
          <p className="text-sm opacity-75">عادتی ثبت نشده</p>
        ) : (
          <ul className="space-y-1">
            {habits.slice(0, 3).map((h) => (
              <li key={h.id} className="text-sm">✓ {h.title}</li>
            ))}
          </ul>
        )}
      </div>

      <div className="glass p-4">
        <h3 className="font-semibold mb-2">یادداشت سریع</h3>
        <textarea
          placeholder="یادداشت امروز..."
          className="w-full px-3 py-2 bg-card rounded-md"
          rows={3}
        />
      </div>
    </div>
  );
}
