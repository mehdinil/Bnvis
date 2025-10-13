@echo off
chcp 65001 >nul
title Tablo APK Builder - Automated

echo.
echo ╔════════════════════════════════════════════╗
echo ║   🚀 Tablo APK Builder - خودکار           ║
echo ╚════════════════════════════════════════════╝
echo.

REM Change to project directory
cd /d "%~dp0"

echo 📍 پوشه فعلی: %CD%
echo.

REM Check if Flutter is available
echo 🔍 بررسی Flutter...
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter یافت نشد!
    echo.
    echo لطفاً Flutter را به PATH اضافه کنید یا:
    echo    set PATH=%PATH%;C:\src\flutter\bin
    echo.
    pause
    exit /b 1
)

flutter --version
echo.

REM Step 1: Clean
echo ════════════════════════════════════════════
echo 🧹 مرحله 1/3: پاک کردن فایل‌های قبلی...
echo ════════════════════════════════════════════
flutter clean
if %errorlevel% neq 0 (
    echo ❌ خطا در clean!
    pause
    exit /b 1
)
echo ✅ Clean موفق
echo.

REM Step 2: Get dependencies
echo ════════════════════════════════════════════
echo 📦 مرحله 2/3: دریافت Dependencies...
echo ════════════════════════════════════════════
echo این ممکن است 30 ثانیه طول بکشد...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ خطا در pub get!
    pause
    exit /b 1
)
echo ✅ Dependencies نصب شدند
echo.

REM Step 3: Build APK
echo ════════════════════════════════════════════
echo 🏗️ مرحله 3/3: ساخت APK...
echo ════════════════════════════════════════════
echo این ممکن است 3-5 دقیقه طول بکشد...
echo لطفاً صبر کنید...
echo.

flutter build apk --release

if %errorlevel% neq 0 (
    echo.
    echo ════════════════════════════════════════════
    echo ❌ ساخت APK ناموفق بود!
    echo ════════════════════════════════════════════
    echo.
    echo راهکارهای ممکن:
    echo 1. VPN یا Hotspot موبایل را روشن کنید
    echo 2. فایل android/gradle.properties را چک کنید
    echo 3. log بالا را بررسی کنید
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════
echo ✅ APK با موفقیت ساخته شد!
echo ════════════════════════════════════════════
echo.
echo 📱 مسیر فایل:
echo    build\app\outputs\flutter-apk\app-release.apk
echo.

REM Check file size
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    for %%A in ("build\app\outputs\flutter-apk\app-release.apk") do (
        set size=%%~zA
        set /a size_mb=%%~zA/1024/1024
    )
    echo 📊 حجم فایل: !size_mb! MB تقریباً
    echo.
    
    echo 🎉 حالا می‌توانید APK را نصب کنید:
    echo    - فایل را به موبایل منتقل کنید
    echo    - روی فایل کلیک کنید و نصب کنید
    echo.
    
    REM Open folder
    echo 📂 باز کردن پوشه...
    start "" explorer "build\app\outputs\flutter-apk"
) else (
    echo ⚠️ فایل APK یافت نشد!
)

echo.
echo ════════════════════════════════════════════
pause
