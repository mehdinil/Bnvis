@echo off
chcp 65001 >nul
echo.
echo ====================================
echo 🚀 Tablo - Setup خودکار
echo ====================================
echo.

REM بررسی Flutter
echo 📋 بررسی Flutter SDK...
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Flutter یافت نشد!
    echo.
    echo لطفاً Flutter را نصب کنید:
    echo 1. از این لینک دانلود کنید: https://docs.flutter.dev/get-started/install/windows
    echo 2. به PATH اضافه کنید
    echo 3. PowerShell را ببندید و دوباره باز کنید
    echo.
    pause
    exit /b 1
)

echo ✅ Flutter یافت شد
echo.

REM Clean
echo 📋 پاک کردن cache قبلی...
call flutter clean
echo.

REM Pub Get
echo 📋 دریافت dependencies...
echo این ممکن است چند دقیقه طول بکشد...
call flutter pub get
if %errorlevel% neq 0 (
    echo ❌ خطا در دریافت dependencies
    pause
    exit /b 1
)
echo ✅ Dependencies نصب شدند
echo.

REM Build Runner
echo 📋 ساخت Hive adapters...
echo این ممکن است 30-60 ثانیه طول بکشد...
call flutter pub run build_runner build --delete-conflicting-outputs
if %errorlevel% neq 0 (
    echo ❌ خطا در build_runner
    pause
    exit /b 1
)
echo ✅ Adapters ساخته شدند
echo.

REM بررسی فایل‌ها
echo 📋 بررسی فایل‌های تولید شده...
if exist "lib\features\journal\models\goal.g.dart" (
    echo ✅ goal.g.dart
) else (
    echo ❌ goal.g.dart یافت نشد
)

if exist "lib\features\journal\models\task.g.dart" (
    echo ✅ task.g.dart
) else (
    echo ❌ task.g.dart یافت نشد
)

if exist "lib\features\journal\models\habit.g.dart" (
    echo ✅ habit.g.dart
) else (
    echo ❌ habit.g.dart یافت نشد
)

if exist "lib\features\journal\models\journal_entry.g.dart" (
    echo ✅ journal_entry.g.dart
) else (
    echo ❌ journal_entry.g.dart یافت نشد
)
echo.

REM دستگاه‌ها
echo 📋 دستگاه‌های موجود:
call flutter devices
echo.

echo ====================================
echo 🎉 Setup با موفقیت انجام شد!
echo ====================================
echo.
echo حالا می‌توانید اجرا کنید:
echo   flutter run
echo.
echo یا دابل کلیک روی run.bat
echo.

pause