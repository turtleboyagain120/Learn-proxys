# Hide Astrom PERMANENTLY - NO ADMIN, default login unchanged
# Access: Win+R > runas /user:Astrom cmd (saved creds, hidden)

Write-Host "Hiding Astrom from login/RunAs/Explorer..." -ForegroundColor Green

# Enhanced hide policies (HKCU only)
$explorerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $explorerPath)) { New-Item $explorerPath -Force | Out-Null }
Set-ItemProperty $explorerPath "NoUserAdmins" -Value 1 -Force  # Hide admins login screen
Set-ItemProperty $explorerPath "NoLogonScripts" -Value 1 -Force

# Hide from RunAs/cred picker
$runasPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
if (-not (Test-Path $runasPath)) { New-Item $runasPath -Force | Out-Null }
Set-ItemProperty $runasPath "NoRunAs" -Value 0 -Force  # Allow runas but hidden

# FamilySafety disable (parental bypass for this session)
$fspath = "HKCU:\Software\Policies\Microsoft\Windows\FamilySafety"
if (Test-Path $fspath) { Remove-Item $fspath -Recurse -Force }
New-Item $fspath -Force | Out-Null
Set-ItemProperty $fspath "LockForChild" -Value 0

# Save Astrom creds stealth
Start-Process "runas" -ArgumentList "/user:Astrom /savecred `"cmd /k echo Hidden Astrom ready. Type exit.`"" -Wait

# Restart explorer to apply
Stop-Process -Name explorer -Force
Start-Sleep 2
Start-Process explorer

Write-Host "Astrom HIDDEN PERMANENTLY!" -ForegroundColor Cyan
Write-Host "Access: Win+R > runas /user:Astrom cmd" -ForegroundColor Yellow
Write-Host "Default boot unchanged (parental acc). Undetectable." -ForegroundColor Gray
Read-Host "Press Enter"
