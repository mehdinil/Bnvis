# 🚀 راهنمای کامل Setup - پروژه Tablo (GoalPad)

این راهنما برای Windows 10/11 نوشته شده، اما برای macOS/Linux هم قابل استفاده است.

---

## 📋 فهرست مطالب

1. [نصب Flutter SDK](#1-نصب-flutter-sdk)
2. [تنظیم PATH و Verification](#2-تنظیم-path-و-verification)
3. [نصب Dependencies پروژه](#3-نصب-dependencies-پروژه)
4. [تولید Hive Adapters](#4-تولید-hive-adapters)
5. [تنظیمات Android (Permissions)](#5-تنظیمات-android-permissions)
6. [تنظیمات iOS (Permissions)](#6-تنظیمات-ios-permissions)
7. [اجرای پروژه](#7-اجرای-پروژه)
8. [تست Feature Export/Import](#8-تست-feature-exportimport)
9. [اجرای تست‌های واحد](#9-اجرای-تستهای-واحد)
10. [رفع خطاهای رایج](#10-رفع-خطاهای-رایج)

---

## 1. نصب Flutter SDK

### روش 1: دانلود مستقیم (توصیه می‌شود)

#### برای Windows:

```powershell
# 1. به سایت Flutter بروید:
# https://docs.flutter.dev/get-started/install/windows

# 2. فایل ZIP را دانلود کنید (Flutter 3.22 یا بالاتر)
# مثلاً: flutter_windows_3.22.0-stable.zip

# 3. فایل را Extract کنید به مسیری مثل:
# C:\src\flutter
# یا
# C:\flutter

# 4. مطمئن شوید که مسیر نهایی اینگونه است:
# C:\src\flutter\bin\flutter.bat
```

#### برای macOS:

```bash
# دانلود از سایت:
# https://docs.flutter.dev/get-started/install/macos

# یا با Homebrew:
brew install --cask flutter
```

#### برای Linux:

```bash
# دانلود فایل tar.xz از سایت
cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.0-stable.tar.xz
tar xf flutter_linux_3.22.0-stable.tar.xz

# اضافه کردن به PATH:
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

---

## 2. تنظیم PATH و Verification

### Windows:

#### راه 1: از طریق PowerShell (موقت - فقط برای session فعلی):

```powershell
# اضافه کردن Flutter به PATH
$env:Path += ";C:\src\flutter\bin"

# تست
flutter --version
```

#### راه 2: تنظیم دائمی (توصیه می‌شود):

```powershell
# 1. Windows Key + R بزنید
# 2. تایپ کنید: sysdm.cpl
# 3. تب "Advanced" → "Environment Variables"
# 4. در بخش "System variables" (یا "User variables"):
#    - متغیر Path را پیدا کنید
#    - دکمه Edit
#    - New بزنید و اضافه کنید:
#      C:\src\flutter\bin
# 5. OK → OK → OK
# 6. PowerShell را ببندید و دوباره باز کنید
```

### Verification:

```powershell
# بستن و باز کردن PowerShell دوباره، سپس:
flutter --version
flutter doctor
```

**خروجی مورد انتظار:**

```
Flutter 3.22.0 • channel stable
Framework • revision ...
Engine • revision ...
Tools • Dart 3.4.0
```

---

### Flutter Doctor - بررسی مشکلات:

```powershell
flutter doctor -v
```

**چیزهایی که باید نصب باشند:**

- ✅ Flutter SDK
- ✅ Android toolchain (Android Studio + SDK)
- ✅ Chrome (برای web development - اختیاری)
- ✅ Visual Studio (برای Windows desktop - اختیاری)
- ⚠️ Android Studio یا VS Code (یکی کافی است)

**اگر Android toolchain نداشتید:**

1. **نصب Android Studio:**
   - دانلود از: https://developer.android.com/studio
   - نصب کنید (همه options پیش‌فرض را قبول کنید)

2. **نصب Android SDK:**
   ```powershell
   # در Android Studio:
   # Tools → SDK Manager
   # نصب کنید: Android SDK Platform-Tools و Android SDK Build-Tools
   ```

3. **Accept licenses:**
   ```powershell
   flutter doctor --android-licenses
   # دکمه 'y' را بزنید برای همه
   ```

---

## 3. نصب Dependencies پروژه

### مرحله 1: رفتن به دایرکتوری پروژه

```powershell
# در PowerShell:
cd C:\Users\ASUS\Desktop\Tablo\goalpad

# تأیید اینکه در مسیر صحیح هستید:
ls pubspec.yaml
```

**باید فایل `pubspec.yaml` را ببینید.**

---

### مرحله 2: Clean (در صورت وجود مشکل قبلی)

```powershell
flutter clean
```

این فولدرهای `build/` و `.dart_tool/` را پاک می‌کند.

---

### مرحله 3: دریافت Dependencies

```powershell
flutter pub get
```

**خروجی مورد انتظار:**

```
Running "flutter pub get" in goalpad...
Resolving dependencies...
+ file_picker 6.1.1
+ flutter_riverpod 2.5.1
+ hive 2.2.3
+ hive_flutter 1.1.0
+ intl 0.19.0
+ path_provider 2.1.1
+ share_plus 7.2.1
+ uuid 4.5.1
+ build_runner 2.4.8 (dev)
+ hive_generator 2.0.1 (dev)
Changed X dependencies!
```

---

### ❌ خطای رایج: Version conflict

اگر خطای version conflict گرفتید:

```powershell
# آپدیت همه dependencies:
flutter pub upgrade

# یا فقط یک package:
flutter pub upgrade hive
```

---

## 4. تولید Hive Adapters

**چرا نیاز است؟**  
Hive برای serialize کردن objects به TypeAdapters نیاز دارد که با `build_runner` generate می‌شوند.

### دستور اصلی:

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

**این دستور چه کاری انجام می‌دهد؟**
- فایل‌های `*.g.dart` را می‌سازد (goal.g.dart, task.g.dart, habit.g.dart, journal_entry.g.dart)
- در کنار هر model که `@HiveType` دارد

**خروجی مورد انتظار:**

```
[INFO] Generating build script...
[INFO] Generating build script completed, took 2.5s
[INFO] Creating build script snapshot...
[INFO] Creating build script snapshot completed, took 3.1s
[INFO] Building new asset graph...
[INFO] Building new asset graph completed, took 1.2s
[INFO] Checking for unexpected pre-existing outputs...
[INFO] Checking for unexpected pre-existing outputs completed, took 0.1s
[INFO] Running build...
[INFO] Generating outputs...
[INFO] Generating outputs completed, took 2.3s
[INFO] Succeeded after 2.4s with 4 outputs
```

### بررسی فایل‌های ساخته شده:

```powershell
ls lib\features\journal\models\*.g.dart
```

**باید ببینید:**
- `goal.g.dart`
- `task.g.dart`
- `habit.g.dart`
- `journal_entry.g.dart`

---

### ❌ خطای رایج: Build runner conflicts

```powershell
# اگر خطا گرفتید:
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 5. تنظیمات Android (Permissions)

### فایل: `android/app/src/main/AndroidManifest.xml`

باز کنید و اضافه کنید:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <!-- Permissions for file operations -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" 
                     android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
                     android:maxSdkVersion="32" />
    
    <!-- For Android 13+ (API 33+) -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

    <application
        android:label="Tablo"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:requestLegacyExternalStorage="true">
        
        <!-- ... بقیه تنظیمات ... -->
        
    </application>
</manifest>
```

**نکته:** با Android 13+، نیازی به WRITE_EXTERNAL_STORAGE نیست چون از scoped storage استفاده می‌شود.

---

### فایل: `android/app/build.gradle`

مطمئن شوید `minSdkVersion` حداقل 21 است:

```gradle
android {
    defaultConfig {
        applicationId "com.example.goalpad"
        minSdkVersion 21  // حداقل 21 برای file_picker
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}
```

---

## 6. تنظیمات iOS (Permissions)

### فایل: `ios/Runner/Info.plist`

باز کنید و قبل از `</dict>` اضافه کنید:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Tablo needs access to photo library to import backup files</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>Tablo needs access to save exported backup files</string>

<key>NSDocumentsFolderUsageDescription</key>
<string>Tablo needs access to documents folder to export/import data</string>

<key>UIFileSharingEnabled</key>
<true/>

<key>LSSupportsOpeningDocumentsInPlace</key>
<true/>
```

---

### نکات iOS:

1. **Deployment Target:** حداقل iOS 12 (در `ios/Podfile`):
   ```ruby
   platform :ios, '12.0'
   ```

2. **نصب Pods:**
   ```bash
   cd ios
   pod install
   cd ..
   ```

---

## 7. اجرای پروژه

### مرحله 1: لیست دستگاه‌های موجود

```powershell
flutter devices
```

**خروجی نمونه:**

```
3 connected devices:

sdk gphone64 arm64 (mobile) • emulator-5554 • android-arm64  • Android 13 (API 33)
iPhone 14 Pro (mobile)      • 12345678-...   • ios           • com.apple.CoreSimulator.SimRuntime.iOS-16-0
Chrome (web)                • chrome         • web-javascript • Google Chrome 118.0
```

---

### مرحله 2: اجرای روی Android Emulator

```powershell
# اگر emulator خاموش است، روشن کنید:
# Android Studio → AVD Manager → Play button

# سپس:
flutter run -d emulator-5554
```

یا اگر فقط یک دستگاه دارید:

```powershell
flutter run
```

---

### مرحله 3: اجرای روی دستگاه فیزیکی (Android)

1. **USB Debugging را فعال کنید:**
   - Settings → About Phone → Build Number (7 بار tap کنید)
   - Settings → Developer Options → USB Debugging (ON)

2. **موبایل را به PC وصل کنید**

3. **اجرا:**
   ```powershell
   flutter devices  # باید دستگاه را ببینید
   flutter run
   ```

---

### مرحله 4: Hot Reload در حین اجرا

وقتی اپ در حال اجراست:

- **Hot Reload:** در terminal تایپ کنید: `r`
- **Hot Restart:** در terminal تایپ کنید: `R`
- **Quit:** `q`

---

### خروجی نرمال:

```
Launching lib\main.dart on sdk gphone64 arm64 in debug mode...
Running Gradle task 'assembleDebug'...
✓  Built build\app\outputs\flutter-apk\app-debug.apk.
Installing build\app\outputs\flutter-apk\app.apk...
Debug service listening on ws://127.0.0.1:12345/...
Synced 0.0MB.

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
```

---

## 8. تست Feature Export/Import

### سناریو تست کامل:

#### 1️⃣ ایجاد داده‌های نمونه:

```
1. اپ را باز کنید
2. تب Goals → FAB → "Learn Flutter", Priority High
3. تب Habits → FAB → "Exercise Daily"
4. تب Journal → FAB → یک entry بنویسید
```

#### 2️⃣ تست Export:

```
1. تب Settings (آیکون تنظیمات)
2. بررسی کنید: Data Overview نشان می‌دهد:
   - Goals: 1
   - Habits: 1
   - Journal Entries: 1
3. دکمه "Export Data" → کلیک
4. باید share sheet باز شود (Android/iOS)
5. فایل را در Google Drive یا Files ذخیره کنید
6. SnackBar سبز: "Export Successful! X items exported"
```

#### 3️⃣ بررسی فایل JSON:

```powershell
# فایل export شده را در text editor باز کنید
# باید ببینید:
{
  "version": "1.0.0",
  "exportDate": "2025-10-01T...",
  "data": {
    "goals": [...],
    "habits": [...],
    "journal": [...]
  }
}
```

#### 4️⃣ تست Import:

```
1. یک Goal دیگر بسازید: "Test Goal 2"
2. Settings → Import Data
3. Confirmation dialog → Import
4. فایل JSON export شده را انتخاب کنید
5. SnackBar: "Import Successful! X items imported, Y skipped"
6. بررسی: Goals list باید هر دو goal را نشان دهد
```

---

## 9. اجرای تست‌های واحد

### تست همه فایل‌ها:

```powershell
flutter test
```

### تست فقط export/import:

```powershell
flutter test test\export_import_test.dart
```

### تست با verbose output:

```powershell
flutter test --verbose
```

**خروجی مورد انتظار:**

```
00:00 +0: loading test\export_import_test.dart
00:01 +1: Goal toJson and fromJson should work correctly
00:01 +2: Task toJson and fromJson should work correctly
00:01 +3: Habit toJson and fromJson should work correctly
00:01 +4: JournalEntry toJson and fromJson should work correctly
00:01 +5: Goal with null optional fields should serialize correctly
00:02 +5: All tests passed!
```

---

## 10. رفع خطاهای رایج

### ❌ خطا: `flutter not recognized`

**راه‌حل:**
1. PATH را درست تنظیم کنید (بخش 2)
2. PowerShell را ببندید و باز کنید
3. تست: `flutter --version`

---

### ❌ خطا: `goal.g.dart not found`

**راه‌حل:**

```powershell
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### ❌ خطا: `Failed to load dynamic library 'libflutter.so'`

**راه‌حل:**

```powershell
flutter clean
flutter pub get
flutter run
```

---

### ❌ خطا: `Gradle build failed`

**راه‌حل:**

```powershell
# 1. پاک کردن cache:
cd android
.\gradlew clean
cd ..

# 2. دوباره build:
flutter clean
flutter pub get
flutter run
```

---

### ❌ خطا: `MissingPluginException`

**معنی:** Plugin native code اجرا نشده.

**راه‌حل:**

```powershell
# Hot Restart نه Hot Reload!
# در terminal اپ که در حال اجراست:
R  # (حرف بزرگ R)

# یا:
flutter run --no-hot
```

---

### ❌ خطا: `PlatformException: read_external_storage`

**راه‌حل:**

1. چک کنید `AndroidManifest.xml` permissions دارد
2. روی Android 13+: مجوزها را در Settings اپ دستی بدهید
3. اپ را uninstall و دوباره نصب کنید

---

### ❌ خطا: `File picker cancelled`

**معنی:** کاربر dialog را کنسل کرده (نه خطا!)

اگر واقعاً مشکل دارید:

```powershell
# لاگ‌ها را بخوانید:
flutter logs
```

---

### 📊 خواندن لاگ‌ها:

#### روش 1: در حین اجرا

```powershell
flutter run -v
```

این همه لاگ‌ها را نشان می‌دهد.

#### روش 2: لاگ‌های دستگاه

```powershell
# Android:
flutter logs

# یا با adb:
adb logcat | findstr "flutter"
```

#### روش 3: لاگ‌های Dart

در کد، `debugPrint()` استفاده شده:

```dart
debugPrint('Export error: $e');
```

این در console flutter run نشان داده می‌شود.

---

### 🔍 Debugging در VS Code / Android Studio

#### VS Code:

1. F5 را بزنید (یا Run → Start Debugging)
2. Breakpoint بگذارید (کلیک کنار شماره خط)
3. کد را step-by-step اجرا کنید

#### Android Studio:

1. Run → Debug 'main.dart'
2. Debugger tab را باز کنید
3. Breakpoints و Variables را ببینید

---

## 🎯 چک‌لیست نهایی

قبل از اینکه به feature بعدی بروید:

- [ ] `flutter doctor` بدون خطای critical
- [ ] `flutter pub get` موفق
- [ ] `build_runner` بدون خطا اجرا شد
- [ ] فایل‌های `.g.dart` ساخته شدند
- [ ] `flutter run` اپ را اجرا می‌کند
- [ ] Settings tab نمایش داده می‌شود
- [ ] Export Data کار می‌کند و share dialog باز می‌شود
- [ ] فایل JSON معتبر ساخته می‌شود
- [ ] Import Data فایل را می‌خواند
- [ ] Stats به‌روز می‌شوند
- [ ] `flutter test` همه تست‌ها pass می‌شوند
- [ ] هیچ linter error نیست

---

## 🆘 در صورت مشکل

اگر بعد از تمام این مراحل مشکل داشتید:

1. **لاگ‌ها را بخوانید:**
   ```powershell
   flutter run -v > log.txt 2>&1
   ```

2. **Flutter را به‌روز کنید:**
   ```powershell
   flutter upgrade
   flutter doctor
   ```

3. **Cache را پاک کنید:**
   ```powershell
   flutter clean
   flutter pub cache repair
   flutter pub get
   ```

4. **IDE را restart کنید**

5. **سیستم را restart کنید** (جدی!)

---

## 🎓 منابع اضافی

- [Flutter Docs](https://docs.flutter.dev)
- [Riverpod Docs](https://riverpod.dev)
- [Hive Docs](https://docs.hivedb.dev)
- [pub.dev packages](https://pub.dev)

---

## 📞 دریافت کمک

اگر خطای خاصی داشتید که در اینجا نیست:

1. متن کامل خطا را کپی کنید
2. در Google جستجو کنید: `"متن خطا" flutter`
3. Stack Overflow و GitHub Issues را بررسی کنید
4. Issue جدید در repository باز کنید

---

**آخرین بروزرسانی:** October 1, 2025  
**نسخه راهنما:** 1.0  
**سازگار با:** Flutter 3.22+, Windows/macOS/Linux

---

**موفق باشید! 🚀**

