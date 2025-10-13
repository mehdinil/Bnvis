@echo off
chcp 65001 >nul
cls

set "PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\src\flutter\bin;%PATH%"

echo ========================================
echo   Goalpad Final APK Build
echo ========================================
echo.

echo [1/4] Cleaning...
flutter clean

echo.
echo [2/4] Getting dependencies...
flutter pub get

echo.
echo [3/4] Building debug APK (for testing)...
flutter build apk

echo.
echo [4/4] Building release APK (final)...
flutter build apk --release --android-skip-build-dependency-validation

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo.
    echo ========================================
    echo   SUCCESS!
    echo ========================================
    echo.
    echo APK Location:
    echo %CD%\build\app\outputs\flutter-apk\app-release.apk
    echo.
    explorer build\app\outputs\flutter-apk
) else (
    echo.
    echo ========================================
    echo   BUILD FAILED
    echo ========================================
    echo Check errors above
)

echo.
pause

