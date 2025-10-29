@echo off
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" status
"C:\Program Files\Git\bin\git.exe" commit -m "ci: trigger workflow"
"C:\Program Files\Git\bin\git.exe" push origin main
