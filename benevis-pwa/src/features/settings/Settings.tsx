import React from 'react';
import { clearAll } from '@/data/storage';

export default function Settings() {
  async function clearData() {
    if (confirm('آیا مطمئنید که می‌خواهید تمام داده‌ها را پاک کنید؟')) {
      await clearAll();
      window.location.hash = '#/onboarding';
    }
  }

  return (
    <div className="space-y-4">
      <div className="glass p-4">
        <h2 className="text-xl font-bold mb-4">تنظیمات</h2>
        
        <div className="space-y-3">
          <div>
            <label className="block text-sm mb-1">تم</label>
            <select className="w-full px-3 py-2 bg-card rounded-md">
              <option value="benevis">بنفش-آبی (Benevis)</option>
              <option value="emerald">سبز-فیروزه‌ای</option>
              <option value="neomorph">نئومورفیک</option>
            </select>
          </div>

          <div>
            <label className="block text-sm mb-1">حالت</label>
            <div className="flex gap-2">
              <button className="flex-1 px-3 py-2 bg-card rounded-md">تیره</button>
              <button className="flex-1 px-3 py-2 bg-card rounded-md">روشن</button>
            </div>
          </div>

          <div>
            <label className="block text-sm mb-1">زبان</label>
            <div className="flex gap-2">
              <button className="flex-1 px-3 py-2 bg-accent text-white rounded-md">فارسی</button>
              <button className="flex-1 px-3 py-2 bg-card rounded-md">English</button>
            </div>
          </div>

          <button onClick={clearData} className="w-full px-4 py-2 bg-red-600 text-white rounded-md mt-4">
            پاک کردن تمام داده‌ها
          </button>
        </div>
      </div>

      <div className="glass p-4 text-sm text-center opacity-75">
        <p>نسخه 1.0.0</p>
        <p>Benevis © 2025</p>
      </div>
    </div>
  );
}
