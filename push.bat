@echo off
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" commit -m "ci: manual Flutter workflow"
"C:\Program Files\Git\bin\git.exe" push origin main
echo Done!
