# 📋 Tablo - دستورات ضروری (Cheat Sheet)

## ⚡ دستورات اصلی

```powershell
# Setup اولیه
cd goalpad
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# اجرا
flutter devices
flutter run
flutter run -d emulator-5554

# تست
flutter test
flutter test test\export_import_test.dart

# لاگ
flutter logs
flutter run -v
```

---

## 🔧 رفع خطا

```powershell
# خطای build_runner
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

# خطای Gradle
cd android && .\gradlew clean && cd ..
flutter clean && flutter pub get

# خطای Plugin
# در terminal اپ: R (Hot Restart)

# Reset کامل
flutter clean
flutter pub cache repair
flutter pub get
```

---

## 🔍 دیباگ

```powershell
# چک کردن SDK
flutter doctor -v

# بررسی dependencies
flutter pub deps

# بررسی generated files
ls lib\features\journal\models\*.g.dart

# Android logs
adb logcat | findstr "flutter"
```

---

## 📱 دستگاه‌ها

```powershell
# لیست دستگاه‌ها
flutter devices

# اجرا روی Android
flutter run -d android

# اجرا روی iOS
flutter run -d ios

# اجرا روی emulator خاص
flutter run -d emulator-5554
```

---

## 🧪 تست در اپ

1. Goals → FAB → "Test Goal"
2. Settings → Export Data → Share
3. Settings → Import Data → Pick file
4. بررسی: Stats updated ✅

---

## 📁 فایل‌های مهم

```
goalpad/
├── lib/main.dart
├── lib/features/journal/
│   ├── models/*.dart (+ *.g.dart)
│   ├── data/local/data_export_service.dart
│   └── ui/pages/settings_page.dart
├── android/app/src/main/AndroidManifest.xml
├── test/export_import_test.dart
└── pubspec.yaml
```

---

## 🎯 Hot Keys

در terminal اپ:
- `r` - Hot Reload 🔥
- `R` - Hot Restart 🔄
- `q` - Quit ❌
- `h` - Help

---

## 🐛 خطاهای رایج

| خطا | راه‌حل |
|-----|--------|
| `flutter not recognized` | PATH + Restart PowerShell |
| `*.g.dart not found` | `build_runner build` |
| `Gradle failed` | `gradlew clean` |
| `MissingPluginException` | Hot Restart (R) |
| `File picker failed` | Check permissions |

---

## 📦 Dependencies

```yaml
flutter_riverpod: ^2.5.1
hive: ^2.2.3
hive_flutter: ^1.1.0
path_provider: ^2.1.1
share_plus: ^7.2.1
file_picker: ^6.1.1
uuid: ^4.5.1
intl: ^0.19.0
```

---

## 🔑 Android Permissions

در `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

---

## 📞 راهنماهای تفصیلی

- `QUICKSTART.md` - شروع سریع
- `SETUP_GUIDE.md` - راهنمای کامل
- `FEATURE_EXPORT_IMPORT.md` - Feature docs
- `INTEGRATION_GUIDE.md` - تست و integration

---

**Last Updated:** Oct 2025 | **Flutter:** 3.22+

