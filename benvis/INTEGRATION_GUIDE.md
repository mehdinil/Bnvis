# 🚀 راهنمای Integration - Feature Export/Import

## دستورات گام‌به‌گام برای اجرا

### 1️⃣ نصب Dependencies

```powershell
# در دایرکتوری goalpad
flutter pub get
```

**خروجی مورد انتظار:**
```
Running "flutter pub get" in goalpad...
+ file_picker 6.1.1
+ path_provider 2.1.1
+ share_plus 7.2.1
...
Changed X dependencies!
```

---

### 2️⃣ اجرای تست‌ها (اختیاری اما توصیه می‌شود)

```powershell
flutter test test/export_import_test.dart
```

**خروجی مورد انتظار:**
```
00:02 +5: All tests passed!
```

---

### 3️⃣ اجرای اپلیکیشن

```powershell
# روی emulator یا device متصل
flutter run
```

یا برای hot reload بهتر:

```powershell
flutter run -d <device-id>
```

---

## 📱 تست Feature در اپلیکیشن

### سناریو تست کامل:

#### ✅ مرحله 1: ایجاد داده‌های Sample

1. اپ را باز کنید
2. به تب **Goals** بروید:
   - یک Goal جدید بسازید: "Learn Flutter"
   - Priority: High (1)
   - Due date: یک تاریخ آینده
   
3. به تب **Habits** بروید:
   - یک Habit بسازید: "Morning Exercise"
   - Frequency: Daily
   - یکی دوبار tick کنید

4. به تب **Journal** بروید:
   - یک entry بنویسید
   - Mood انتخاب کنید
   - Tag اضافه کنید (e.g., #happy)

---

#### ✅ مرحله 2: تست Export

1. به تب **Settings** (آیکون تنظیمات در navigation bar) بروید

2. در بخش **DATA OVERVIEW** باید ببینید:
   - Goals: 1
   - Tasks: X
   - Habits: 1
   - Journal Entries: 1

3. روی **Export Data** کلیک کنید

4. **باید اتفاقات زیر بیفتد:**
   - یک loading indicator ظاهر شود
   - Share dialog باز شود (Android/iOS share sheet)
   - بتوانید فایل را save کنید (e.g., در Google Drive، Files)
   - یک SnackBar سبز با پیام "Export Successful!" ظاهر شود

5. **فایل export شده:**
   - نام: `tablo_backup_[timestamp].json`
   - سایز: چند KB (بسته به تعداد داده‌ها)
   - فرمت: JSON قابل خواندن

---

#### ✅ مرحله 3: بررسی فایل Export

فایل JSON را در یک text editor باز کنید. باید ساختاری مشابه این داشته باشد:

```json
{
  "version": "1.0.0",
  "exportDate": "2025-10-01T...",
  "data": {
    "goals": [
      {
        "id": "...",
        "title": "Learn Flutter",
        "priority": 1,
        ...
      }
    ],
    "tasks": [...],
    "habits": [...],
    "journal": [...]
  },
  "metadata": {
    "totalGoals": 1,
    ...
  }
}
```

---

#### ✅ مرحله 4: تست Import

**آماده‌سازی:**
1. در Settings، یک Goal دیگر بسازید: "Test Goal 2"
2. حالا در بخش DATA OVERVIEW باید Goals: 2 باشد

**اجرای Import:**
1. روی **Import Data** کلیک کنید
2. یک Confirmation dialog ظاهر می‌شود
3. روی **Import** کلیک کنید
4. فایل JSON که قبلاً export کردید را انتخاب کنید

**نتیجه مورد انتظار:**
- SnackBar سبز: "Import Successful!"
- پیام: "X items imported, Y items skipped"
- Items تکراری (با همان ID) skip می‌شوند
- Stats به‌روز می‌شود

---

#### ✅ مرحله 5: Verify Data

1. به تب **Goals** برگردید - باید تمام goals را ببینید
2. به تب **Habits** برگردید - باید habits import شده را ببینید
3. به تب **Journal** برگردید - باید entries import شده را ببینید

---

## 🐛 عیب‌یابی

### مشکل: Share dialog باز نمی‌شود

**راه‌حل:**
- روی Android: مجوزهای storage را بررسی کنید
- روی iOS: Info.plist را بررسی کنید
- Emulator را restart کنید

### مشکل: Import کار نمی‌کند

**بررسی‌ها:**
```dart
// در console دنبال این لاگ‌ها بگردید:
debugPrint('Export error: ...');
debugPrint('Import error: ...');
```

**چک کنید:**
1. فایل JSON معتبر است؟ (در jsonlint.com validate کنید)
2. فرمت فایل صحیح است؟ (version و data keys دارد)
3. File picker مجوز دارد؟

### مشکل: Duplicate IDs

Import به صورت پیش‌فرض duplicates را skip می‌کند. این رفتار عمدی است.

**اگر می‌خواهید overwrite کنید:**
در `data_export_service.dart` خط زیر را تغییر دهید:
```dart
// از این:
if (!goalsBox.containsKey(goal.id)) {
  await goalsBox.put(goal.id, goal);
}

// به این (overwrite mode):
await goalsBox.put(goal.id, goal);
```

---

## 🎯 چک‌لیست تست کامل

- [ ] Dependencies نصب شدند (`flutter pub get`)
- [ ] تست‌های unit پاس شدند (`flutter test`)
- [ ] اپ بدون خطا اجرا می‌شود
- [ ] Settings tab در navigation bar ظاهر است
- [ ] Data overview stats صحیح نمایش داده می‌شود
- [ ] Export دکمه کار می‌کند و share dialog باز می‌شود
- [ ] فایل JSON با فرمت صحیح ساخته می‌شود
- [ ] Import فایل JSON را می‌خواند
- [ ] Duplicate items skip می‌شوند
- [ ] SnackBar پیام‌های success/error نمایش می‌دهد
- [ ] UI responsive است و loading states دارد
- [ ] کد بدون linter errors است

---

## 📱 تست روی Devices مختلف

### Android:
```powershell
flutter run -d <android-device-id>
```

**نکات:**
- Share sheet از Android share system استفاده می‌کند
- File picker به MANAGE_EXTERNAL_STORAGE نیاز ندارد (scoped storage)

### iOS:
```powershell
flutter run -d <ios-device-id>
```

**نکات:**
- Share sheet از UIActivityViewController استفاده می‌کند
- مجوز photo library لازم نیست

### Web (محدودیت دارد):
```powershell
flutter run -d chrome
```

**هشدار:** File picker روی web محدودیت‌هایی دارد. برای production از platform check استفاده کنید.

---

## 🔍 لاگ‌های مفید برای Debug

در کد، این لاگ‌ها اضافه شده‌اند:

```dart
debugPrint('Export error: $e\n$stackTrace');
debugPrint('Import error: $e\n$stackTrace');
debugPrint('Error importing goal: $e');
```

برای دیدن لاگ‌ها:
```powershell
flutter run -v
# یا
flutter logs
```

---

## 🎓 یادگیری بیشتر

### فایل‌هایی که باید بررسی کنید:

1. **Models:** `lib/features/journal/models/*.dart`
   - toJson/fromJson patterns

2. **Service:** `lib/features/journal/data/local/data_export_service.dart`
   - Async file operations
   - Error handling patterns

3. **UI:** `lib/features/journal/ui/pages/settings_page.dart`
   - Material 3 components
   - SnackBar usage
   - Loading states

4. **Tests:** `test/export_import_test.dart`
   - Unit testing models
   - JSON validation

---

## 🚀 در Production

### قبل از release:

1. **پاک کردن لاگ‌های debug:**
   ```dart
   // همه debugPrint را حذف یا به logger تبدیل کنید
   ```

2. **اضافه کردن Analytics:**
   ```dart
   // Track export/import events
   analytics.logEvent('data_exported', {...});
   ```

3. **اضافه کردن Privacy Notice:**
   - به کاربر اطلاع دهید داده‌های export شده رمزگذاری نیستند

4. **تست روی devices واقعی:**
   - حداقل 3 دستگاه Android مختلف
   - حداقل 2 دستگاه iOS مختلف

---

## 📞 در صورت مشکل

1. Issue در GitHub بسازید
2. لاگ‌های console را attach کنید
3. Device info را بنویسید (Android/iOS version)
4. Steps to reproduce را توضیح دهید

---

**Happy Coding!** 🎉

این feature یک foundation عالی برای features بعدی است:
- ✅ Serialization ready
- ✅ File operations tested
- ✅ UI patterns established

**بعدی:** Notifications + Progress Tracking! 🚀


