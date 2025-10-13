@echo off
chcp 65001 >nul
cls
echo ========================================
echo   Goalpad APK Builder
echo ========================================
echo.

:: Set PATH
set "PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%"

echo [Step 1/5] Checking Flutter...
echo.
flutter --version
if errorlevel 1 (
    echo.
    echo [ERROR] Flutter not found!
    echo Make sure Flutter is installed at C:\src\flutter
    pause
    exit /b 1
)

echo.
echo [Step 2/5] Checking Android SDK...
echo.
flutter doctor -v
echo.
echo Check above output for any missing components.
echo If "Android SDK Platform 35" is missing, you need to install it.
echo.
pause

echo.
echo [Step 3/5] Cleaning...
flutter clean

echo.
echo [Step 4/5] Getting dependencies...
flutter pub get
if errorlevel 1 (
    echo.
    echo [ERROR] Failed to get dependencies!
    pause
    exit /b 1
)

echo.
echo [Step 5/5] Building APK (this takes 5-10 minutes)...
echo.
flutter build apk --release
if errorlevel 1 (
    echo.
    echo ========================================
    echo   BUILD FAILED!
    echo ========================================
    echo.
    echo Common fixes:
    echo 1. Install Android SDK Platform 35 in Android Studio
    echo 2. Check logs above for specific errors
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   BUILD SUCCESS!
echo ========================================
echo.
echo APK Location:
echo %CD%\build\app\outputs\flutter-apk\app-release.apk
echo.
echo Opening folder...
explorer build\app\outputs\flutter-apk
echo.
pause

