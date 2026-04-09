@echo off
REM Create/setup Astrom non-admin access - NO ADMIN needed (for existing acc)
REM Username: Astrom, Password: hack2024 (reuse from hide bat)

echo Checking if Astrom account exists...
net user | findstr /i "Astrom" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Astrom account not found. Cannot create w/o admin/IT bypass needed.
    echo Create manually once (admin), then rerun this.
    pause
    exit /b 1
)

echo Astrom found! Setting up saved creds ^(run once)...
runas /user:Astrom /savecred "cmd /k echo Login saved! Type exit."

echo Setting HKCU AutoAdminLogon for Astrom...
powershell -ExecutionPolicy Bypass -Command ^
"$path = 'HKCU:\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon'; ^
if (-not (Test-Path $path)) { New-Item $path -Force }; ^
Set-ItemProperty $path 'AutoAdminLogon' -Value 1 -Force; ^
Set-ItemProperty $path 'DefaultUserName' -Value 'Astrom' -Force; ^
Set-ItemProperty $path 'DefaultPassword' -Value 'hack2024' -Force; ^
Write-Host 'Auto-login to Astrom setup complete! Reboot to test.'"

echo Reboot to test auto-login to Astrom ^(Win+L also shows).
echo Optional: Hide admins now...
call HIDE_NO_ADMIN.bat
pause
