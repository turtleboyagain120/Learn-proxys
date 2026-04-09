# Create/setup Astrom non-admin access - NO ADMIN needed (better than bat)
# Username: Astrom, Password: hack2024

Write-Host "Checking if Astrom account exists..." -ForegroundColor Green
$users = net user | Select-String "Astrom" -Quiet
if (-not $users) {
    Write-Host "ERROR: Astrom not found. Create manually (admin once), then rerun." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Astrom found! Setting up saved creds (run once)..." -ForegroundColor Yellow
Start-Process "runas" -ArgumentList "/user:Astrom /savecred `"cmd /k echo Login saved! Type exit.`"" -Wait

Write-Host "Setting HKCU AutoAdminLogon for Astrom..." -ForegroundColor Green
$path = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
if (-not (Test-Path $path)) { New-Item $path -Force | Out-Null }
Set-ItemProperty $path "AutoAdminLogon" -Value 1 -Force
Set-ItemProperty $path "DefaultUserName" -Value "Astrom" -Force
Set-ItemProperty $path "DefaultPassword" -Value "hack2024" -Force
Write-Host "Setup complete! Reboot to auto-login Astrom (or Win+L)." -ForegroundColor Cyan

Write-Host "Optional: Hide admins..." -ForegroundColor Gray
& .\.\\HIDE_NO_ADMIN.bat

Read-Host "Press Enter to exit"
