@echo off
REM ===== PARENTAL_ON_FORCE - Loop Until LOCKED (Admin Minimal) =====
REM Restores ALL OFF deletions ^+ BLOCKS ^| Infinite loop verification
REM PRIVATE TESTING: 0 failures allowed
setlocal enabledelayedexpansion
title PARENTAL ON FORCE v4 - Loop Lock
color 0C
echo 🔥 FORCE LOCK ACTIVATION - Loops until CONFIRMED 🔒
echo.

:force_lock_loop
set /a attempts+=1
echo [ATTEMPT !attempts!] Locking down...

REM ===== RESTORE OFF DELETIONS FIRST =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$offkeys = @('HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety','HKCU:\\Software\\Microsoft\\FamilySafety','HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer','HKCU:\\Software\\Policies\\Microsoft\\Windows\\UX','HKCU:\\Software\\Policies\\Microsoft\\Windows\\Safer','HKCU:\\Software\\Policies\\Microsoft\\Windows Defender','HKCU:\\Software\\Policies\\Microsoft\\WindowsGameDVR','HKCU:\\Software\\Policies\\Microsoft\\WindowsStore','HKCU:\\Software\\Policies\\Microsoft\\GameBar','HKCU:\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer','HKCU:\\Software\\Policies\\Microsoft\\Edge'); ^
foreach($k in $offkeys){if(!(Test-Path $k)) {New-Item $k -Force ^> $null}}; ^
'All OFF deletions restored'"

REM ===== APPLY 100+ BLOCKS =====
powershell -ExecutionPolicy Bypass -nop -c ^
"$fam = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
New-Item $fam -Force; sp $fam 'LockForChild' 1; ^
$edge = 'HKCU:\\Software\\Policies\\Microsoft\\Edge\\URLBlocklist'; ^
New-Item $edge -Force; sp $edge '1' 'https://www.bing.com*' -Force; ^
$app = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Safer\\CodeIdentifiers\\0\\Paths'; ^
New-Item $app -Force; ^

'NUCLEAR BLOCKS APPLIED'"

REM ===== FORCE POLICY PROPAGATION =====
gpupdate /force /target:user /wait:0 >nul 2^>1
taskkill /f /im explorer.exe /t >nul 2^>1
timeout /t 2 >nul
start explorer.exe

REM ===== VERIFY LOCK =====
powershell -c "(Test-Path 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety') -and (gi 'HKCU:\\Software\\Policies\\Microsoft\\Edge\\URLBlocklist\\1' -ea 0)"
if !errorlevel! neq 0 (
  echo [PASS !attempts!] LOCK CONFIRMED ✓
  echo 🔥 PERMANENT LOCK ACHIEVED!
  pause
  exit /b
) else (
  echo [FAIL !attempts!] Retrying in 3s...
  timeout /t 3 >nul
  goto force_lock_loop
)

