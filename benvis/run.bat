@echo off
chcp 65001 >nul
echo.
echo 🚀 اجرای Tablo...
echo.
echo دستگاه‌های موجود:
call flutter devices
echo.
echo در حال اجرا...
echo.
echo نکات:
echo   r  - Hot Reload 🔥
echo   R  - Hot Restart 🔄
echo   q  - Quit ❌
echo.
call flutter run
pause