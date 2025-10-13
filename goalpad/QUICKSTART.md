# ⚡ Quick Start - دستورات به ترتیب

این راهنمای سریع است. برای جزئیات بیشتر `SETUP_GUIDE.md` را ببینید.

---

## 🎯 پیش‌نیاز: Flutter SDK

### Windows:

```powershell
# 1. دانلود Flutter SDK از:
# https://docs.flutter.dev/get-started/install/windows

# 2. Extract به C:\src\flutter

# 3. اضافه کردن به PATH:
# Windows Key + R → sysdm.cpl
# Advanced → Environment Variables
# System Variables → Path → Edit → New
# اضافه کنید: C:\src\flutter\bin

# 4. PowerShell جدید باز کنید و تست کنید:
flutter --version
flutter doctor
```

---

## 🚀 دستورات اصلی (به ترتیب اجرا کنید)

```powershell
# 1. رفتن به دایرکتوری پروژه
cd C:\Users\ASUS\Desktop\Tablo\goalpad

# 2. بررسی فایل pubspec.yaml
cat pubspec.yaml

# 3. پاک کردن cache قبلی (اگر مشکل دارید)
flutter clean

# 4. دریافت dependencies
flutter pub get

# 5. تولید Hive adapters (*.g.dart files)
flutter pub run build_runner build --delete-conflicting-outputs

# 6. بررسی فایل‌های ساخته شده
ls lib\features\journal\models\*.g.dart

# 7. چک کردن دستگاه‌های متصل
flutter devices

# 8. اجرای پروژه
flutter run

# یا برای دستگاه خاص:
flutter run -d emulator-5554
```

---

## ✅ خروجی‌های مورد انتظار

### بعد از `flutter pub get`:

```
Running "flutter pub get" in goalpad...
Resolving dependencies...
+ file_picker 6.1.1
+ flutter_riverpod 2.5.1
+ hive 2.2.3
+ path_provider 2.1.1
+ share_plus 7.2.1
Changed X dependencies!
```

### بعد از `build_runner`:

```
[INFO] Succeeded after 2.4s with 4 outputs
  goal.g.dart
  task.g.dart
  habit.g.dart
  journal_entry.g.dart
```

### بعد از `flutter run`:

```
Launching lib\main.dart on sdk gphone64 arm64 in debug mode...
✓ Built build\app\outputs\flutter-apk\app-debug.apk.
Installing build\app\outputs\flutter-apk\app.apk...

Flutter run key commands.
r Hot reload. 🔥
R Hot restart.
q Quit.
```

---

## 🧪 تست Export/Import

بعد از اجرا:

```
1. اپ باز می‌شود
2. تب Goals → FAB → یک Goal بسازید
3. تب Settings → Export Data
4. Share dialog باز می‌شود
5. فایل JSON ذخیره می‌شود
6. Settings → Import Data
7. همان فایل را انتخاب کنید
8. Success! ✅
```

---

## 🧪 اجرای تست‌ها

```powershell
# تست همه
flutter test

# تست export/import
flutter test test\export_import_test.dart

# با verbose
flutter test --verbose
```

**باید ببینید:**
```
00:02 +5: All tests passed! ✅
```

---

## ❌ رفع خطاهای رایج

### خطا: `flutter not recognized`

```powershell
# PATH را چک کنید:
echo $env:Path

# اگر Flutter نیست، دوباره به PATH اضافه کنید:
$env:Path += ";C:\src\flutter\bin"
flutter --version
```

### خطا: `goal.g.dart not found`

```powershell
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### خطا: `Gradle build failed`

```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### خطا: `MissingPluginException`

```powershell
# Hot Restart کنید (نه Hot Reload):
# در terminal که اپ در حال اجراست تایپ کنید:
R  # حرف بزرگ R
```

---

## 📱 اجرا روی Android Emulator

```powershell
# 1. Android Studio را باز کنید
# 2. AVD Manager → Play button (روی یک emulator)

# 3. بعد از اینکه emulator روشن شد:
flutter devices

# 4. اجرا:
flutter run -d emulator-5554
```

---

## 📱 اجرا روی موبایل فیزیکی

```powershell
# Android:
# 1. Settings → About Phone → Build Number (7 بار tap)
# 2. Developer Options → USB Debugging (ON)
# 3. موبایل را وصل کنید
# 4. اجرا:
flutter devices
flutter run
```

---

## 📊 لاگ‌ها

```powershell
# لاگ کامل:
flutter run -v

# یا در حین اجرا:
flutter logs

# Android logcat:
adb logcat | findstr "flutter"
```

---

## 🔍 Debugging

در VS Code:
- F5 → Start Debugging
- Breakpoint: کلیک کنار شماره خط
- Step over: F10

---

## 🎯 چک‌لیست سریع

- [ ] Flutter SDK نصب و در PATH
- [ ] `flutter doctor` OK
- [ ] `flutter pub get` موفق
- [ ] `build_runner` اجرا شد
- [ ] فایل‌های `.g.dart` وجود دارند
- [ ] `flutter run` اپ را اجرا می‌کند
- [ ] Settings tab کار می‌کند
- [ ] Export/Import موفق
- [ ] `flutter test` pass می‌شود

---

## 🆘 کمک فوری

```powershell
# Reset کامل:
flutter clean
flutter pub cache repair
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run

# اگر باز هم کار نکرد:
# 1. IDE را ببندید
# 2. دستورات بالا را دوباره اجرا کنید
# 3. سیستم را restart کنید
```

---

## 📞 منابع

- راهنمای کامل: `SETUP_GUIDE.md`
- Feature guide: `FEATURE_EXPORT_IMPORT.md`
- Integration: `INTEGRATION_GUIDE.md`

---

**موفق باشید! 🚀**

