
# خلاصه بیلد APK — Goalpad Flutter

## 🎯 وضعیت فعلی

✅ **تنظیمات اصلاح شد:**
- `android/app/build.gradle` → `compileSdk = 35` و `targetSdk = 35`

⚠️ **بیلد خودکار ناقص ماند:**
- مشکل: محدودیت encoding در ترمینال PowerShell (حرف `C` به `:` تبدیل می‌شود)
- فرمان‌های `flutter clean` و `pub get` موفق بودند
- `flutter build apk --release` به دلیل مشکل PATH اجرا نشد

📦 **APK هنوز ساخته نشده است.**

---

## 🛠️ مراحل دستی (حتماً انجام بده)

### مرحله ۱: باز کردن Command Prompt (نه PowerShell!)
```
Win+R → cmd → Enter
```

### مرحله ۲: رفتن به پوشه پروژه
```cmd
cd /d "C:\Users\ASUS\Desktop\Tablo\goalpad"
```

### مرحله ۳: تنظیم PATH (فقط این سشن)
```cmd
set PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%
```

### مرحله ۴: بررسی Flutter
```cmd
flutter --version
flutter doctor -v
```
اگر خطا "Android SDK Platform 35" داد، یکی از این کارها:

**روش A) Android Studio:**
- بازکردن: SDK Manager
- نصب: Android 15 (API 35) + Build-Tools 35.0.0

**روش B) خط فرمان (اگر sdkmanager دارید):**
```cmd
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-35" "build-tools;35.0.0"
```

### مرحله ۵: بیلد APK ریلیز
```cmd
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📦 خروجی نهایی

بعد از اتمام موفقیت‌آمیز:
```
✅ APK Path: C:\Users\ASUS\Desktop\Tablo\goalpad\build\app\outputs\flutter-apk\app-release.apk
```

---

## 🔍 اگر خطا گرفتی

### خطای "Android SDK Platform 35 not found":
- SDK را از Android Studio نصب کن (بالا ↑)

### خطای "Gradle build failed":
```cmd
cd android
gradlew clean
cd ..
flutter build apk --release
```

### خطای "PowerShell not found":
- مطمئن شو PATH شامل `C:\Windows\System32\WindowsPowerShell\v1.0` است

---

## 📝 گزارش لاگ‌ها

اگر باز مشکل داشتی، این فایل‌ها را بفرست:
- `logs\00_env_from_build.txt` ← محیط و ابزارها
- `logs\flutter_doctor.txt` ← وضعیت Flutter
- خروجی ترمینال از `flutter build apk --release`

---

**تاریخ آخرین به‌روزرسانی:** 8 اکتبر 2025
**وضعیت:** آماده بیلد دستی (تمام تنظیمات صحیح است)
