# 📊 گزارش نهایی — Goalpad Flutter به APK

## ✅ کارهای انجام‌شده

### 1. تنظیم فایل‌های Gradle
```gradle
// android/app/build.gradle
android {
    compileSdk = 35          // ✓ تغییر از 34
    defaultConfig {
        minSdk = 23          // ✓ تنظیم شد
        targetSdk = 35       // ✓ تغییر از flutter.targetSdkVersion
    }
}
```

### 2. ایجاد اسکریپت‌های بیلد
- ✅ `goalpad/BUILD_NOW.bat` — اسکریپت کامل با لاگ
- ✅ `goalpad/QUICK_BUILD.bat` — اسکریپت ساده
- ✅ `goalpad/build_apk_release.bat` — اسکریپت اصلی
- ✅ `goalpad/fix_ps_and_flutter.bat` — بررسی محیط
- ✅ `goalpad/sdk_install_android35.bat` — نصب SDK

### 3. ایجاد مستندات
- ✅ `REPORT.md` — گزارش تشخیصی کامل
- ✅ `BUILD_SUMMARY.md` — خلاصه بیلد
- ✅ `BUILD_STATUS.md` — وضعیت فعلی
- ✅ `.cursorrules` — راهنمای Cursor
- ✅ `.cursorignore` — فایل‌های نادیده گرفته‌شده

---

## ⚠️ محدودیت فعلی

**مشکل:** محیط PowerShell در Cursor Agent Mode محدودیت‌های encoding و PATH دارد که باعث می‌شود:
- حرف `C` به `:` تبدیل شود
- فرمان‌های `flutter` به درستی اجرا نشوند
- CMD scripts نتوانند به درستی کار کنند

**راه‌حل:** بیلد باید **دستی** در CMD واقعی ویندوز انجام شود.

---

## 🎯 دستورالعمل نهایی (کپی-پیست مستقیم)

### مرحله ۱: بازکردن Command Prompt
```
Win+R → cmd → Enter
```

### مرحله ۲: اجرای دستورات (کل بلوک را کپی-پیست کن)
```cmd
cd /d C:\Users\ASUS\Desktop\Tablo\goalpad
set PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%
flutter --version
flutter doctor -v
```

### مرحله ۳: بررسی SDK
اگر خطای **"Android SDK Platform 35"** یا **"android.jar not found"** دیدی:

**راه‌حل A) Android Studio (ساده‌تر):**
1. بازکن: Android Studio
2. برو: `File → Settings → Appearance & Behavior → System Settings → Android SDK`
3. زیر "SDK Platforms": تیک بزن روی **Android 15.0 (API 35)**
4. زیر "SDK Tools": تیک بزن روی **Android SDK Build-Tools 35.0.0**
5. Apply → OK

**راه‌حل B) خط فرمان:**
```cmd
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-35" "build-tools;35.0.0"
```

### مرحله ۴: بیلد APK
```cmd
flutter clean
flutter pub get
flutter build apk --release
```

این فرایند **5-10 دقیقه** طول می‌کشد.

---

## 📦 خروجی نهایی

بعد از اتمام موفقیت‌آمیز:
```
✅ APK Path:
C:\Users\ASUS\Desktop\Tablo\goalpad\build\app\outputs\flutter-apk\app-release.apk

✅ حجم تقریبی: 20-40 MB
✅ نسخه اندروید: 5.0+ (API 23+)
✅ امضا: Debug (برای تست)
```

---

## 🔧 رفع خطاهای رایج

### خطا: "PowerShell executable not found"
```cmd
set PATH=C:\Windows\System32\WindowsPowerShell\v1.0;%PATH%
```

### خطا: "Could not find platforms\android-35\android.jar"
- نصب SDK Platform 35 (بالا ↑)

### خطا: "Gradle build failed"
```cmd
cd android
gradlew clean
cd ..
flutter build apk --release
```

### خطا: "Java heap space"
در `android/gradle.properties` اضافه کن:
```properties
org.gradle.jvmargs=-Xmx2048m -XX:MaxMetaspaceSize=512m
```

---

## 📱 نصب APK روی گوشی

### روش 1: کابل USB
1. فعال کردن "Developer Options" و "USB Debugging" در گوشی
2. اتصال گوشی به کامپیوتر
3. کپی فایل APK به گوشی
4. در گوشی: File Manager → APK → Install

### روش 2: بدون کابل
1. APK را به Google Drive یا سرور آپلود کن
2. از گوشی دانلود کن
3. Install

---

## 🚀 انتشار در Google Play

### مرحله 1: ساخت Keystore
```cmd
keytool -genkey -v -keystore C:\Users\ASUS\.keystores\goalpad-release.keystore -alias goalpad -keyalg RSA -keysize 2048 -validity 10000
```

### مرحله 2: تنظیم Signing
در `android/key.properties`:
```properties
storePassword=<PASSWORD>
keyPassword=<PASSWORD>
keyAlias=goalpad
storeFile=C:\\Users\\ASUS\\.keystores\\goalpad-release.keystore
```

در `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### مرحله 3: بیلد Bundle
```cmd
flutter build appbundle --release
```

خروجی: `build\app\outputs\bundle\release\app-release.aab`

---

## 📊 خلاصه پروژه

| Item | Value |
|------|-------|
| **نام اپ** | Goalpad |
| **Package ID** | com.example.goalpad |
| **نسخه** | 1.0.0+1 |
| **Min SDK** | 23 (Android 5.0) |
| **Target SDK** | 35 (Android 15) |
| **Flutter** | 3.35.5 |
| **Dart** | 3.9.2 |
| **وضعیت Gradle** | آماده بیلد ✓ |
| **وضعیت SDK** | نیاز به نصب Platform 35 |

---

## ✨ نکات بهینه‌سازی

### کاهش حجم APK
در `android/app/build.gradle`:
```gradle
android {
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### Multi-APK (برای حجم کمتر)
```gradle
android {
    splits {
        abi {
            enable true
            reset()
            include 'armeabi-v7a', 'arm64-v8a'
            universalApk false
        }
    }
}
```

---

## 📞 پشتیبانی

اگر باز هم مشکل داشتی، این اطلاعات را ارسال کن:
1. خروجی `flutter doctor -v`
2. خروجی `flutter build apk --release`
3. محتویات `android/app/build.gradle`
4. مسیر Android SDK: `%ANDROID_SDK_ROOT%`

---

**تاریخ:** 8 اکتبر 2025  
**وضعیت:** ✅ آماده بیلد دستی  
**اقدام بعدی:** اجرای دستورات مرحله ۲-۴ در CMD
