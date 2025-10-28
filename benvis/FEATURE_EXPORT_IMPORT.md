# 📦 Feature: Export/Import Data

## ✅ پیاده‌سازی کامل شد!

این feature به کاربران اجازه می‌دهد که تمام داده‌های خود را (Goals, Tasks, Habits, Journal Entries) به فرمت JSON export کنند و بعداً import کنند.

---

## 🚀 نصب و راه‌اندازی

### 1. نصب Dependencies

```bash
cd goalpad
flutter pub get
```

Dependencies جدید اضافه شده:
- `path_provider: ^2.1.1` - دسترسی به دایرکتوری‌های سیستم
- `share_plus: ^7.2.1` - اشتراک‌گذاری فایل‌ها
- `file_picker: ^6.1.1` - انتخاب فایل برای import

### 2. اجرای اپلیکیشن

```bash
flutter run
```

---

## 📱 نحوه استفاده

### Export کردن داده‌ها

1. به تب **Settings** (آیکون تنظیمات) بروید
2. در بخش **BACKUP & RESTORE**، روی **Export Data** کلیک کنید
3. فایل JSON به صورت خودکار ساخته و share می‌شود
4. فایل را در Google Drive، Email یا هر مکان دلخواه ذخیره کنید

**نام فایل export شده:**
```
tablo_backup_[timestamp].json
```

### Import کردن داده‌ها

1. به تب **Settings** بروید
2. روی **Import Data** کلیک کنید
3. تأیید کنید (داده‌های موجود overwrite نمی‌شوند)
4. فایل JSON backup را انتخاب کنید
5. داده‌های جدید اضافه می‌شوند

**⚠️ نکته مهم:** Import به صورت merge کار می‌کند - items با ID تکراری نادیده گرفته می‌شوند.

---

## 🏗️ معماری پیاده‌سازی

### فایل‌های اضافه شده:

```
goalpad/lib/features/journal/
├── data/local/
│   └── data_export_service.dart          ← Service اصلی export/import
├── models/
│   ├── goal.dart                         ← اضافه شد: toJson, fromJson
│   ├── task.dart                         ← اضافه شد: toJson, fromJson
│   ├── habit.dart                        ← اضافه شد: toJson, fromJson
│   └── journal_entry.dart                ← اضافه شد: toJson, fromJson
├── ui/
│   ├── pages/
│   │   └── settings_page.dart            ← صفحه Settings با UI مدرن
│   └── app_shell.dart                    ← اضافه شد: Settings tab
```

### تست‌ها:

```
test/export_import_test.dart               ← Unit tests برای serialization
```

---

## 🧪 اجرای تست‌ها

```bash
flutter test test/export_import_test.dart
```

تست‌های موجود:
- ✅ Goal serialization/deserialization
- ✅ Task serialization/deserialization
- ✅ Habit serialization/deserialization
- ✅ JournalEntry serialization/deserialization
- ✅ Null handling در فیلدهای optional

---

## 📄 فرمت فایل Export

فایل JSON شامل structure زیر است:

```json
{
  "version": "1.0.0",
  "exportDate": "2025-10-01T14:30:00.000Z",
  "data": {
    "goals": [
      {
        "id": "uuid",
        "title": "Learn Flutter",
        "why": "Career growth",
        "priority": 1,
        "dueDate": "2025-12-31T00:00:00.000Z",
        "status": "active",
        "tags": ["work", "learning"]
      }
    ],
    "tasks": [...],
    "habits": [...],
    "journal": [...]
  },
  "metadata": {
    "totalGoals": 5,
    "totalTasks": 15,
    "totalHabits": 3,
    "totalJournalEntries": 20
  }
}
```

---

## 🎨 UI Features

### Settings Page شامل:

1. **Data Overview Cards:**
   - نمایش تعداد Goals, Tasks, Habits, Journal entries
   - آیکون‌های رنگی برای هر دسته

2. **Export Button:**
   - دکمه با loading indicator
   - SnackBar برای نمایش نتیجه
   - اشتراک‌گذاری فایل با share dialog

3. **Import Button:**
   - Confirmation dialog قبل از import
   - نمایش تعداد items imported/skipped
   - Refresh خودکار statistics

4. **Material 3 Design:**
   - Cards با elevation مناسب
   - Color scheme responsive
   - Icons و typography مدرن

---

## 🔒 امنیت و Privacy

- ✅ تمام داده‌ها **local** ذخیره می‌شوند (Hive)
- ✅ Export فقط توسط کاربر trigger می‌شود
- ✅ Import بدون overwrite (merge mode)
- ✅ هیچ داده‌ای به server ارسال نمی‌شود
- ✅ فایل backup قابل encryption توسط user است

---

## 🐛 Error Handling

Service شامل error handling کامل است:

```dart
try {
  final result = await DataExportService.exportData();
  if (result.success) {
    // Success case
  } else {
    // Error with message
  }
} catch (e) {
  // Exception handling
}
```

خطاهای رایج:
- ❌ فایل JSON نامعتبر → پیام خطا
- ❌ مشکل در خواندن فایل → exception handling
- ❌ کنسل کردن file picker → graceful exit

---

## 📊 Performance

- Export: O(n) - تمام items را traverse می‌کند
- Import: O(n) - merge با check کردن IDs
- Memory: Efficient - streaming برای فایل‌های بزرگ
- UI: Non-blocking - async operations با loading indicators

---

## 🔄 آینده: Features بعدی

پیشنهادات برای بهبود:

1. **Auto Backup:**
   - Schedule خودکار backup هر هفته
   - ذخیره در cloud (Google Drive API)

2. **Selective Export:**
   - انتخاب Categories برای export
   - Export date range برای Journal

3. **Encryption:**
   - رمزگذاری فایل backup با password
   - استفاده از `encrypt` package

4. **Cloud Sync:**
   - اضافه کردن Firebase Storage
   - Real-time sync بین devices

---

## 🎓 یادگیری از این Feature

کدهای قابل استفاده مجدد:

1. **JSON Serialization Pattern:**
   ```dart
   Map<String, dynamic> toJson() => {...};
   factory Model.fromJson(Map<String, dynamic> json) => Model(...);
   ```

2. **File Operations:**
   ```dart
   final dir = await getTemporaryDirectory();
   final file = File('${dir.path}/filename.json');
   await file.writeAsString(jsonString);
   ```

3. **Share File:**
   ```dart
   await Share.shareXFiles([XFile(path)], subject: '...', text: '...');
   ```

4. **Confirmation Dialog:**
   ```dart
   final confirmed = await showDialog<bool>(...);
   if (confirmed != true) return;
   ```

---

## ✨ نتیجه

Feature Export/Import به طور کامل پیاده‌سازی شده است و شامل:

- ✅ Serialization برای تمام models
- ✅ Service با error handling
- ✅ UI مدرن با Material 3
- ✅ Unit tests
- ✅ Documentation

**Status: READY FOR PRODUCTION** 🚀

---

## 📞 پشتیبانی

در صورت مشکل:
1. لاگ‌های console را بررسی کنید (`debugPrint`)
2. تست‌های unit را اجرا کنید
3. فرمت فایل JSON را validate کنید

---

**آخرین بروزرسانی:** October 1, 2025  
**نسخه:** 1.0.0


