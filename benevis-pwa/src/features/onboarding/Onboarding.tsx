import React, { useState } from 'react';
import { saveUser } from '@/data/storage';

export default function Onboarding() {
  const [name, setName] = useState('');
  const [age, setAge] = useState('');
  const [goal, setGoal] = useState('');

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    await saveUser({ name, age: parseInt(age), goal });
    window.location.hash = '#/';
  }

  return (
    <div className="glass p-6 space-y-4">
      <h2 className="text-2xl font-bold">خوش آمدید به بِنویس</h2>
      <form onSubmit={submit} className="space-y-3">
        <input
          type="text"
          placeholder="نام شما"
          value={name}
          onChange={e => setName(e.target.value)}
          className="w-full px-3 py-2 bg-card rounded-md"
          required
        />
        <input
          type="number"
          placeholder="سن"
          value={age}
          onChange={e => setAge(e.target.value)}
          className="w-full px-3 py-2 bg-card rounded-md"
          required
        />
        <textarea
          placeholder="هدف اصلی شما چیست؟"
          value={goal}
          onChange={e => setGoal(e.target.value)}
          className="w-full px-3 py-2 bg-card rounded-md"
          rows={3}
          required
        />
        <button type="submit" className="w-full px-4 py-2 bg-accent text-white rounded-md">
          شروع
        </button>
      </form>
    </div>
  );
}
