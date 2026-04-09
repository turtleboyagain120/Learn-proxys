@echo off
REM Parental Controls ON - Run as Admin
powershell -ExecutionPolicy Bypass -Command ^
"$fsp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
New-Item $fsp -Force; ^
Set-ItemProperty $fsp 'LockForChild' -Value 1; ^
Write-Host 'Parental Controls ENABLED'"
taskkill /f /im explorer.exe /t & start explorer.exe
pause

