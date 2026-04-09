@echo off
REM NO-ADMIN-EVER Final – Works WITHOUT admin account access
REM Uses DefaultAccount as-is + FamilySafety bypass only

echo [1/3] FamilySafety OFF (turtl only)...
powershell -ExecutionPolicy Bypass -Command ^
"$fsp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
if (Test-Path $fsp) { Remove-Item $fsp -Recurse -Force }; ^
Write-Host 'FamilySafety DISABLED - turtl free!'"

echo [2/3] Test DefaultAccount status...
net user DefaultAccount

echo [3/3] Stealth Ready! ^
echo 1. Win+R ^> runas /user:DefaultAccount cmd [your current pw]
echo 2. Lock PC ^(Win+L^) - accounts hidden via policy attempt
echo 3. Switch back: Ctrl+Alt+Del ^> turtl

pause

