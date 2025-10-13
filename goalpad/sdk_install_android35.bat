@echo off
setlocal
:: Explicitly set PATH for Android SDK tools
set "PATH=%PATH%;%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin"

if not exist "%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" (
  echo [INFO] sdkmanager not found. Use Android Studio > SDK Manager to install:
  echo  - Android 15 (API 35) SDK Platform
  echo  - Android SDK Build-Tools 35.0.0
  pause
  exit /b 0
)

echo [INFO] Installing Android SDK Platform 35 and Build-Tools 35.0.0...
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-35" "build-tools;35.0.0"
if %errorlevel% neq 0 (
    echo [ERROR] sdkmanager failed to install components.
    pause
    exit /b 1
)
echo [INFO] Android SDK Platform 35 and Build-Tools 35.0.0 installed successfully.
pause
exit /b 0
