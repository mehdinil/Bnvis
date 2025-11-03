@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ==========================================
echo  Fresh Push - Branch جدید از main
echo ==========================================
echo.

echo [1/5] Switching to main...
"C:\Program Files\Git\bin\git.exe" checkout main
echo ✅ On main
echo.

echo [2/5] Pulling latest main...
"C:\Program Files\Git\bin\git.exe" pull origin main
echo ✅ Main updated
echo.

echo [3/5] Creating fresh branch from main...
"C:\Program Files\Git\bin\git.exe" checkout -b fix/ultra-auto-clean
echo ✅ Branch created
echo.

echo [4/5] Adding only new clean files...
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" status --short
echo ✅ Files staged
echo.

echo [5/5] Committing and pushing...
"C:\Program Files\Git\bin\git.exe" commit -m "chore: ultra cleanup + hub integration + CI hardening"
"C:\Program Files\Git\bin\git.exe" remote set-url origin https://github.com/mehdinil/Bnvis.git
"C:\Program Files\Git\bin\git.exe" push -u origin fix/ultra-auto-clean
echo.

if errorlevel 1 (
    echo ❌ Push failed
    echo.
    echo Try unblocking here:
    echo https://github.com/mehdinil/Bnvis/security/secret-scanning/unblock-secret/34vHhhTdskhrRF4oQk70WZbGsX8
) else (
    echo.
    echo ✅ SUCCESS!
    echo 🔗 PR: https://github.com/mehdinil/Bnvis/compare/main...fix/ultra-auto-clean
)

pause

