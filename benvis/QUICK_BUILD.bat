@echo off
echo ====================================
echo   Goalpad APK Builder (Manual)
echo ====================================
echo.

:: Set PATH for this session only
set "PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%"

echo [1/5] Checking Flutter...
flutter --version
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found or PowerShell not in PATH
    pause
    exit /b 1
)

echo.
echo [2/5] Checking Flutter Doctor...
flutter doctor -v

echo.
echo [3/5] Cleaning previous build...
flutter clean

echo.
echo [4/5] Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] pub get failed
    pause
    exit /b 1
)

echo.
echo [5/5] Building Release APK...
echo This may take 5-10 minutes...
flutter build apk --release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo ====================================
echo   BUILD SUCCESS!
echo ====================================
echo.
echo APK Location:
echo build\app\outputs\flutter-apk\app-release.apk
echo.
pause

