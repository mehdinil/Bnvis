@echo off
setlocal

:: Explicitly set PATH for PowerShell and Flutter
set "PATH=C:\\Windows\\System32\\WindowsPowerShell\\v1.0;C:\\Program Files\\PowerShell\\7;C:\\src\\flutter\\bin;%PATH%"

:: Debugging: Verify if powershell and flutter are found in this session
where powershell > NUL 2>&1 || (echo [ERROR] PowerShell not found. Please ensure it's installed. & exit /b 1)
where flutter > NUL 2>&1 || (echo [ERROR] Flutter not found. Please ensure C:\src\flutter\bin is in your system PATH. & exit /b 1)

echo [INFO] PowerShell and Flutter are in PATH.
flutter --version
flutter doctor -v
exit /b 0
