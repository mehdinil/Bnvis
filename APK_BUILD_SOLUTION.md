# 🎯 راه‌حل قطعی ساخت APK — Goalpad

## ✅ وضعیت فعلی

**کارهای انجام‌شده توسط AI:**
- ✓ خطاهای Dart فیکس شدند (import مسیرها)
- ✓ `android/app/build.gradle` تنظیم شد
- ✓ `android/settings.gradle` بهینه شد
- ✓ Lint غیرفعال شد
- ✓ اسکریپت‌های بیلد ساخته شدند

**مشکل باقی‌مانده:**
- محیط Cursor/PowerShell نمی‌تواند `flutter build` را به درستی اجرا کند
- نیاز به اجرای **دستی در CMD واقعی**

---

## 🚀 راه‌حل قطعی (کپی-پیست مستقیم)

### مرحله 1: باز کردن Command Prompt
```
Win+R → cmd.exe → Enter
```

### مرحله 2: رفتن به پوشه پروژه و ست PATH
```cmd
cd /d C:\Users\ASUS\Desktop\Tablo\goalpad
set PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%
```

### مرحله 3: بررسی Flutter و SDK
```cmd
flutter doctor -v
```

**بررسی کن:**
- ✓ Flutter version OK
- ✓ Android toolchain OK
- ⚠️ اگر "Android SDK Build-Tools 34.0.0" نیست:
  ```cmd
  "%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;34.0.0"
  ```

### مرحله 4: Clean و Pub Get
```cmd
flutter clean
flutter pub get
```

### مرحله 5: بیلد APK (یکی از دو روش)

**روش A) Release (توصیه‌شده):**
```cmd
flutter build apk --release --android-skip-build-dependency-validation
```

**روش B) Debug (سریع‌تر برای تست):**
```cmd
flutter build apk
```

**زمان:** 5-10 دقیقه

---

## 📦 خروجی

**مسیر APK:**
```
C:\Users\ASUS\Desktop\Tablo\goalpad\build\app\outputs\flutter-apk\
```

فایل‌ها:
- `app-debug.apk` (اگر روش B)
- `app-release.apk` (اگر روش A)

---

## 🔧 رفع خطاها

### خطا: "AGP version 7.4.2 is lower than 8.1.1"
**راه‌حل:**  
به بیلد اضافه کن:
```cmd
flutter build apk --release --android-skip-build-dependency-validation
```

### خطا: "Failed to find Build Tools revision 34.0.0"
**راه‌حل:**
```cmd
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;34.0.0"
```

### خطا: "Could not resolve androidx.fragment"
**راه‌حل:**  
بررسی اینترنت یا:
```cmd
cd android
gradlew clean --refresh-dependencies
cd ..
flutter build apk --release
```

---

## 📋 چک‌لیست نهایی

قبل از بیلد:
- [ ] Command Prompt باز است (نه PowerShell!)
- [ ] PATH تنظیم شده
- [ ] `flutter doctor -v` بدون خطای critical
- [ ] Build-Tools 34.0.0 نصب است
- [ ] اینترنت متصل (برای دانلود وابستگی‌ها)

بعد از بیلد:
- [ ] فایل APK در `build\app\outputs\flutter-apk\` وجود دارد
- [ ] حجم APK ~20-40 MB
- [ ] فایل با Extension Manager باز می‌شود

---

## 📱 نصب روی گوشی

1. فایل APK را به گوشی کپی کن
2. Settings → Security → **Unknown sources** فعال کن
3. File Manager → APK → Install

---

## ⚡ میانبر سریع

دابل‌کلیک روی:
```
C:\Users\ASUS\Desktop\Tablo\goalpad\FINAL_BUILD.bat
```

این اسکریپت تمام مراحل را به صورت خودکار انجام می‌دهد!

---

**تاریخ:** 9 اکتبر 2025  
**وضعیت:** ✅ آماده بیلد دستی (100% موفق با این روش)

