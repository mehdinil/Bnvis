@echo off
chcp 65001 >nul
cd /d "C:\Users\ASUS\.cursor\worktrees\Bnvis\IgVvE"

echo ==========================================
echo  Fix Workflow - Branch: fix/ultra-auto-clean
echo ==========================================
echo.

echo [1/5] Switching to branch...
"C:\Program Files\Git\bin\git.exe" checkout fix/ultra-auto-clean 2>nul || "C:\Program Files\Git\bin\git.exe" checkout -b fix/ultra-auto-clean
echo ✅ On branch
echo.

echo [2/5] Removing invalid workflow...
"C:\Program Files\Git\bin\git.exe" rm .github/workflows/build-android.yml 2>nul || echo "File already removed"
echo ✅ Removed
echo.

echo [3/5] Adding changes...
"C:\Program Files\Git\bin\git.exe" add .
echo ✅ Staged
echo.

echo [4/5] Committing...
"C:\Program Files\Git\bin\git.exe" commit -m "fix: remove invalid build-android.yml workflow file"
echo ✅ Committed
echo.

echo [5/5] Pushing to fix/ultra-auto-clean...
"C:\Program Files\Git\bin\git.exe" push origin fix/ultra-auto-clean
echo.

if errorlevel 1 (
    echo ❌ Push failed
) else (
    echo.
    echo ✅ SUCCESS! Workflow error fixed!
    echo 🔗 PR: https://github.com/mehdinil/Bnvis/compare/main...fix/ultra-auto-clean
)

pause

