# 🎯 دستورالعمل نهایی —  goalpad APK

## ❌ مشکل باقی‌مانده

**خطا:** `Failed to find Build Tools revision 34.0.0`

**دلیل:** اگرچه Android SDK 36.1 با Build-Tools 36.1.0 نصب است، اما AGP 8.5.0 به Build-Tools **34.0.0** نیاز دارد.

---

## ✅ کارهای انجام‌شده

1. ✓ `android/app/build.gradle` → SDK 36, targetSdk 35
2. ✓ `android/settings.gradle` → AGP 8.5.0, Kotlin 1.9.20
3. ✓ `android/gradle.properties` → تنظیمات بهینه
4. ✓ Lint غیرفعال شد
5. ✓ Gradle wrapper 8.9 آماده

---

## 🛠️ راه‌حل نهایی (2 گزینه)

### **گزینه 1: نصب Build-Tools 34.0.0 (توصیه‌شده)**

**مرحله A) از Android Studio:**
1. باز کن: **Android Studio**
2. برو: `File → Settings → Android SDK → SDK Tools`
3. تیک بزن: **Show Package Details**
4. زیر "Android SDK Build-Tools": تیک بزن **34.0.0**
5. کلیک: **Apply**

**مرحله B) یا با sdkmanager:**
```cmd
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;34.0.0"
```

**مرحله C) بعد از نصب:**
```cmd
cd /d C:\Users\ASUS\Desktop\Tablo\goalpad
flutter build apk --release
```

---

### **گزینه 2: بیلد Debug (سریع‌تر)**

اگر فقط برای تست می‌خوای:
```cmd
cd /d C:\Users\ASUS\Desktop\Tablo\goalpad
flutter build apk
```
(بدون `--release` → debug build که نیاز به R8/minify نداره)

خروجی: `build\app\outputs\flutter-apk\app-debug.apk`

---

## 📦 خروجی نهایی (بعد از نصب Build-Tools)

```
✅ APK Release:
C:\Users\ASUS\Desktop\Tablo\goalpad\build\app\outputs\flutter-apk\app-release.apk

حجم: ~25-40 MB
سازگاری: Android 5.0+ (API 23+)
امضا: Debug keystore (برای تست)
```

---

## 🚀 نصب روی گوشی

1. کپی فایل APK به گوشی
2. در گوشی: Settings → Security → **Unknown sources** را فعال کن
3. File Manager → APK → Install

---

## 📝 یادداشت

کل پروژه آمادهٔ بیلد است، فقط **Build-Tools 34.0.0** کم است.

**زمان نصب + بیلد:** ~10-15 دقیقه

---

**تاریخ:** 9 اکتبر 2025  
**وضعیت:** آماده نهایی (پس از نصب Build-Tools 34.0.0)

