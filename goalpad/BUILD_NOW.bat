@echo off
setlocal EnableDelayedExpansion

:: Create logs directory
if not exist logs mkdir logs

echo ================================================ > logs\build_now.log
echo   Goalpad APK Build - Started
echo   Date: %date% %time%
echo ================================================ >> logs\build_now.log
echo. >> logs\build_now.log

:: Set PATH
set "PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\PowerShell\7;C:\src\flutter\bin;%PATH%"

echo [STEP 1/6] Checking environment... >> logs\build_now.log
echo [STEP 1/6] Checking environment...
where flutter >> logs\build_now.log 2>&1
where powershell >> logs\build_now.log 2>&1

echo. >> logs\build_now.log
echo [STEP 2/6] Flutter version... >> logs\build_now.log
echo [STEP 2/6] Flutter version...
flutter --version >> logs\build_now.log 2>&1
if !errorlevel! neq 0 (
    echo [ERROR] Flutter not found! >> logs\build_now.log
    echo [ERROR] Flutter not found!
    type logs\build_now.log
    pause
    exit /b 1
)

echo. >> logs\build_now.log
echo [STEP 3/6] Flutter doctor... >> logs\build_now.log
echo [STEP 3/6] Flutter doctor...
flutter doctor -v >> logs\build_now.log 2>&1

echo. >> logs\build_now.log
echo [STEP 4/6] Cleaning... >> logs\build_now.log
echo [STEP 4/6] Cleaning...
flutter clean >> logs\build_now.log 2>&1

echo. >> logs\build_now.log
echo [STEP 5/6] Getting dependencies... >> logs\build_now.log
echo [STEP 5/6] Getting dependencies...
flutter pub get >> logs\build_now.log 2>&1
if !errorlevel! neq 0 (
    echo [ERROR] pub get failed! >> logs\build_now.log
    echo [ERROR] pub get failed!
    type logs\build_now.log
    pause
    exit /b 1
)

echo. >> logs\build_now.log
echo [STEP 6/6] Building APK Release... >> logs\build_now.log
echo [STEP 6/6] Building APK Release (this takes 5-10 minutes)...
flutter build apk --release >> logs\build_now.log 2>&1
if !errorlevel! neq 0 (
    echo [ERROR] Build failed! >> logs\build_now.log
    echo [ERROR] Build failed!
    echo Check logs\build_now.log for details
    type logs\build_now.log
    pause
    exit /b 1
)

echo. >> logs\build_now.log
echo ================================================ >> logs\build_now.log
echo   BUILD SUCCESS!
echo ================================================ >> logs\build_now.log
echo. >> logs\build_now.log
echo APK Location: >> logs\build_now.log
echo build\app\outputs\flutter-apk\app-release.apk >> logs\build_now.log
echo. >> logs\build_now.log

echo.
echo ================================================
echo   BUILD SUCCESS!
echo ================================================
echo.
echo APK Location:
echo %CD%\build\app\outputs\flutter-apk\app-release.apk
echo.
echo Full log saved to: logs\build_now.log
echo.
pause
exit /b 0
