# 🚀 Tablo - دستورات Build (Agent-Generated)

## ✅ Environment Status: READY

```
✅ Flutter: 3.24.5
✅ AGP: 7.3.0 (Iran-optimized)
✅ Kotlin: 1.8.0 (Stable)
✅ Gradle: 7.6
✅ Dependencies: Installed
✅ .g.dart Files: Generated
✅ Permissions: Configured
✅ Mirrors: Aliyun + JitPack + Direct Google
```

---

## 🎯 دستورات Build (به ترتیب اجرا کن)

### روش 1: APK Build (Android)

```powershell
# مرحله 1: رفتن به پوشه پروژه
cd C:\Users\ASUS\Desktop\Tablo\goalpad

# مرحله 2: Clean
flutter clean

# مرحله 3: دریافت Dependencies
flutter pub get

# مرحله 4: Build APK (3-5 دقیقه)
flutter build apk --release
```

**خروجی موفق:**
```
✓ Built build\app\outputs\flutter-apk\app-release.apk (15.2MB).
```

**باز کردن پوشه:**
```powershell
explorer build\app\outputs\flutter-apk
```

---

### روش 2: Web Build (Fallback - 100% کار می‌کنه)

```powershell
flutter build web --release
```

**خروجی:**
```
build\web\
├── index.html
├── main.dart.js
└── assets/
```

**Deploy:**
- GitHub Pages: push به `gh-pages` branch
- Netlify: drag & drop پوشه `build/web`
- Vercel: `vercel deploy build/web`

---

### روش 3: Debug Mode (تست سریع)

```powershell
# روی Chrome (فوری):
flutter run -d chrome

# روی موبایل (اگه وصل باشه):
flutter run -d aff415c5
```

---

## 🐛 عیب‌یابی

### خطا: Gradle Plugin Not Found

**راهکار 1: VPN/Hotspot**
```powershell
# 1. VPN یا hotspot موبایل روشن کن
# 2. دوباره build:
flutter clean
flutter build apk --release
```

**راهکار 2: Web Build**
```powershell
flutter build web --release
```

---

### خطا: Execution failed for task

**راهکار:**
```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter build apk --release
```

---

## 🧪 تست پروژه

```powershell
# تست همه
flutter test

# تست Export/Import
flutter test test\export_import_test.dart

# با coverage
flutter test --coverage
```

---

## 📦 فایل‌های خروجی

### APK (Android):
```
build\app\outputs\flutter-apk\
└── app-release.apk  (15-20 MB)
```

**نصب روی موبایل:**
1. فایل را به موبایل منتقل کن
2. دوبار کلیک کن
3. "Install from unknown sources" را تأیید کن
4. نصب!

### Web:
```
build\web\
├── index.html
├── flutter.js
├── main.dart.js
└── assets/
```

---

## 🎯 Quick Commands

```powershell
# Setup کامل (اولین بار)
cd goalpad
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Build APK
flutter build apk --release

# Build Web
flutter build web --release

# Run Debug
flutter run -d chrome

# Test
flutter test
```

---

## ✨ Agent Status

```
✅ Project analyzed
✅ Dependencies verified
✅ Gradle configured (Iran-optimized)
✅ Permissions added
✅ FileProvider configured
✅ Build scripts ready
✅ Documentation updated

🚀 READY TO BUILD!
```

---

**Last Updated:** October 1, 2025  
**Configuration:** Iran-Optimized  
**Build Target:** APK + Web
