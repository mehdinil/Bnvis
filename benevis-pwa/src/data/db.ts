import { openDB, DBSchema, IDBPDatabase } from 'idb';

interface BenevisDB extends DBSchema {
  users: { key: string; value: any };
  habits: { key: string; value: any };
  tasks: { key: string; value: any };
  notes: { key: string; value: any };
}

let dbInstance: IDBPDatabase<BenevisDB> | null = null;

export async function getDB(): Promise<IDBPDatabase<BenevisDB>> {
  if (dbInstance) return dbInstance;
  dbInstance = await openDB<BenevisDB>('benevisDB', 1, {
    upgrade(db) {
      if (!db.objectStoreNames.contains('users')) db.createObjectStore('users');
      if (!db.objectStoreNames.contains('habits')) db.createObjectStore('habits');
      if (!db.objectStoreNames.contains('tasks')) db.createObjectStore('tasks');
      if (!db.objectStoreNames.contains('notes')) db.createObjectStore('notes');
    }
  });
  return dbInstance;
}
