import { getDB } from './db';

export async function getUser() {
  try {
    const db = await getDB();
    return await db.get('users', 'current');
  } catch {
    return JSON.parse(localStorage.getItem('user') || 'null');
  }
}

export async function saveUser(user: any) {
  try {
    const db = await getDB();
    await db.put('users', user, 'current');
  } catch {
    localStorage.setItem('user', JSON.stringify(user));
  }
}

export async function getHabits(): Promise<any[]> {
  try {
    const db = await getDB();
    const all = await db.getAll('habits');
    return all;
  } catch {
    return JSON.parse(localStorage.getItem('habits') || '[]');
  }
}

export async function saveHabit(habit: any) {
  try {
    const db = await getDB();
    await db.put('habits', habit, habit.id);
  } catch {
    const habits = await getHabits();
    habits.push(habit);
    localStorage.setItem('habits', JSON.stringify(habits));
  }
}

export async function clearAll() {
  try {
    const db = await getDB();
    await db.clear('users');
    await db.clear('habits');
    await db.clear('tasks');
    await db.clear('notes');
  } catch {
    localStorage.clear();
  }
}
