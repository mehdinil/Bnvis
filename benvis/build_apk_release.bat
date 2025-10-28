@echo off
setlocal

:: Explicitly set PATH for PowerShell and Flutter for this script
set "PATH=C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\PowerShell\7;C:\src\flutter\bin;%PATH%"

mkdir logs 2>nul

echo ==== ENV CHECKS (from build_apk_release.bat) ==== > logs\00_env_from_build.txt
where powershell >> logs\00_env_from_build.txt 2>&1
where pwsh >> logs\00_env_from_build.txt 2>&1
where flutter >> logs\00_env_from_build.txt 2>&1
flutter --version >> logs\00_env_from_build.txt 2>&1
flutter doctor -v >> logs\00_env_from_build.txt 2>&1
echo PATH=%PATH% >> logs\00_env_from_build.txt 2>&1

echo ==== CLEAN ==== >> logs\10_clean.txt
flutter clean >> logs\10_clean.txt 2>&1 || (echo [ERROR] Flutter clean failed & exit /b 1)

echo ==== PUB GET ==== >> logs\20_pub_get.txt
flutter pub get >> logs\20_pub_get.txt 2>&1 || (echo [ERROR] Flutter pub get failed & exit /b 1)

echo ==== PUB DEPS ==== >> logs\21_pub_deps.txt
flutter pub deps --style=tree >> logs\21_pub_deps.txt 2>&1

echo ==== PUB OUTDATED ==== >> logs\22_pub_outdated.txt
flutter pub outdated >> logs\22_pub_outdated.txt 2>&1

echo ==== BUILD DEBUG ==== >> logs\30_build_debug.txt
flutter build apk >> logs\30_build_debug.txt 2>&1 || (echo [WARN] Debug build might have failed. Check log. & GOTO :SKIP_RELEASE_BUILD)

echo ==== BUILD RELEASE ==== >> logs\40_build_release.txt
flutter build apk --release >> logs\40_build_release.txt 2>&1 || (echo [ERROR] Release build failed & GOTO :BUILD_FAILED)

:BUILD_SUCCESS
echo ==== BUILD SUCCESS ====
echo Debug APK: build\app\outputs\flutter-apk\app-debug.apk
echo Release APK: build\app\outputs\flutter-apk\app-release.apk
exit /b 0

:SKIP_RELEASE_BUILD
echo [INFO] Skipping release build due to debug build warning/failure.
exit /b 0

:BUILD_FAILED
echo [ERROR] Build failed. Check logs in the "logs" folder for details.
exit /b 1
