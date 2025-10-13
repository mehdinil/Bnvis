import React, { useEffect, useState } from 'react';
import { getHabits, saveHabit } from '@/data/storage';

export default function Habits() {
  const [habits, setHabits] = useState<any[]>([]);
  const [newHabit, setNewHabit] = useState('');

  useEffect(() => {
    (async () => {
      const h = await getHabits();
      setHabits(h);
    })();
  }, []);

  async function add() {
    if (!newHabit.trim()) return;
    const habit = { id: Date.now().toString(), title: newHabit, ticks: [] };
    await saveHabit(habit);
    setHabits([...habits, habit]);
    setNewHabit('');
  }

  return (
    <div className="space-y-4">
      <div className="glass p-4">
        <h2 className="text-xl font-bold mb-3">عادت‌های من</h2>
        <div className="flex gap-2">
          <input
            type="text"
            value={newHabit}
            onChange={(e) => setNewHabit(e.target.value)}
            placeholder="عادت جدید..."
            className="flex-1 px-3 py-2 bg-card rounded-md"
          />
          <button onClick={add} className="px-4 py-2 bg-accent text-white rounded-md">
            +
          </button>
        </div>
      </div>

      <div className="space-y-2">
        {habits.map((h) => (
          <div key={h.id} className="glass p-3 flex items-center justify-between">
            <span>{h.title}</span>
            <button className="px-3 py-1 bg-accent/20 rounded-md">✓</button>
          </div>
        ))}
      </div>
    </div>
  );
}
