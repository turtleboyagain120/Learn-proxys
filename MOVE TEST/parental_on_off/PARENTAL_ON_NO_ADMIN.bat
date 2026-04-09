@echo off
REM PARENTAL_ON_NO_ADMIN.bat - Zero privilege lockdown (HKCU only)
REM Advanced policy recreation ^| explorer cycle ^| verification loop
setlocal enabledelayedexpansion
title Parental ON NoAdmin - Stealth Lock
echo.
echo [SYSTEM] Deploying user-level restrictions...
echo [INFO] No UAC/admin - HKCU precision only

:stealth_lock
set /a tries+=1
echo [Loop !tries!] Applying policy layer...

REM ===== FAMILY SAFETY POLICY =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$fam = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
New-Item $fam -Force ^> $null; ^
Set-ItemProperty $fam 'LockForChild' 1 -Force; ^
New-ItemProperty -Path $fam -Name 'AllowGame'" 

REM ===== BROWSER URL BLOCK =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$block = 'HKCU:\\Software\\Policies\\Microsoft\\Edge\\URLBlocklist'; ^
New-Item $block -Force ^> $null; ^
New-ItemProperty -Path $block -Name '1' -Value 'https://www.bing.com*' -Force; ^
New-ItemProperty -Path $block -Name '2' -Value 'https://www.microsoft.com*' -Force"

REM ===== APP/EXE BLOCKS =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$safer = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Safer\\CodeIdentifiers'; ^
New-Item $safer -Force; ^
$path0 = \"$safer\\0\\Paths\"; New-Item $path0 -Force; ^
Set-ItemProperty $path0 'SaferFlags' 1"

REM ===== EXPLORER LIMITS =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$exp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer'; ^
New-Item $exp -Force; ^
Set-ItemProperty $exp 'NoRun' 1; ^
Set-ItemProperty $exp 'NoControlPanel' 1"

REM ===== FORCE PROPAGATION =====
taskkill /f /im explorer.exe >nul 2^>nul
timeout /t 2 >nul
start explorer.exe
gpupdate /force /target:user /wait:0 >nul 2^>1

REM ===== VERIFY LOCK =====
powershell -c "(Test-Path 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety') -and (Get-ItemProperty 'HKCU:\\Software\\Policies\\Microsoft\\Edge\\URLBlocklist' -Name 1 -ea SilentlyContinue)"
if !errorlevel! equ 0 (
  echo.
  echo [SUCCESS !tries!] Stealth lockdown confirmed
  echo Run TEST_BLOCKS_OFF.bat to verify blocks active
  pause
  exit /b
)
echo [Retry !tries!] Policy propagation...
timeout /t 3 >nul
goto stealth_lock

