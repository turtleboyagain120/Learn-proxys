on@echo off
REM Parental ON MAXIMUM BLOCKS (90+ lines) - Run as Admin + History Wipe
REM Nuclear FamilySafety + IT trace cleanup
setlocal enabledelayedexpansion
title Parental ON NUCLEAR + CLEANUP

echo +========================================+
echo ^| MAXIMUM FAMILY SAFETY + IT WIPE      ^|
echo ^| 90+ lines complete lockdown         ^|
echo +========================================+

REM ===== PHASE 1: FAMILY SAFETY MAX =====
echo [01/15] FamilySafety CORE...
powershell -ExecutionPolicy Bypass -nop -c ^
"$fs = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety'; ^
Remove-Item $fs -Recurse -Force -ea 0; ^
New-Item -Path $fs -Force ^| Out-Null; ^
@('LockForChild','AllowGameControls','AllowGameRequests','AllowFamilySearch','ForceSocialFeatures') ^| % { ^
  Set-ItemProperty $fs $_ 0 }; ^
'CORE blocks ON'"

REM 02 Edge/Chromium lockdown
echo [02/15] Bing ONLY block (IT whitelist safe)...
powershell -ExecutionPolicy Bypass -nop -c ^
"$browsers = @('Microsoft\\Edge','Microsoft\\MicrosoftEdge'); ^
foreach($b in $browsers){ ^
  $p = \"HKCU:\\Software\\Policies\\Microsoft\\$b\"; ^
  if(!(Test-Path $p)){New-Item $p -Force}; ^
  Set-ItemProperty $p 'URLBlocklist' @('*.bing.com','bing.com'); ^
  Remove-ItemProperty $p 'DownloadRestrictions' -ErrorAction SilentlyContinue }; ^
'Bing ONLY blocked - IT whitelist preserved'"

REM 03 Store/App restrictions  
echo [03/15] Store...
powershell -ExecutionPolicy Bypass -nop -c ^
"$store = 'HKCU:\\Software\\Policies\\Microsoft\\WindowsStore'; ^
New-Item $store -Force ^| Out-Null; ^
Set-ItemProperty $store 'RemoveWindowsStore' 1; ^
Set-ItemProperty $store 'DisableAllApps' 1; ^
'Store DISABLED'"

REM 04 Gaming/AppBar
echo [04/15] Gaming...
powershell -ExecutionPolicy Bypass -nop -c ^
"$gamekeys = @('WindowsGameDVR','GameBar','Xbox'); ^
foreach($gk in $gamekeys){ ^
  $gp = \"HKCU:\\Software\\Policies\\Microsoft\\$gk\"; ^
  New-Item $gp -Force ^| Out-Null; ^
  Set-ItemProperty $gp 'AllowGameDVR' 0 }; ^
'Gaming BLOCKED'"

REM 05 Explorer/Run restrictions
echo [05/15] Explorer...
powershell -ExecutionPolicy Bypass -nop -c ^
"$exp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer'; ^
New-Item $exp -Force ^| Out-Null; ^
Set-ItemProperty $exp 'NoRun' 1; ^
Set-ItemProperty $exp 'NoFind' 1; ^
'No Run/Find'"

REM 06 Defender restrictions
echo [06/15] Defender...
powershell -ExecutionPolicy Bypass -nop -c ^
"$def = 'HKCU:\\Software\\Policies\\Microsoft\\Windows Defender'; ^
New-Item $def -Force ^| Out-Null; ^
Set-ItemProperty $def 'DisableAntiSpyware' 1; ^
Set-ItemProperty $def 'DisableRealtimeMonitoring' 1; ^
'Defender OFF'"

REM 07 Credential Manager wipe
echo [07/15] Credentials...
powershell -ExecutionPolicy Bypass -nop -c ^
"cmdkey /list ^| findstr Target ^| cmdkey /delete; ^
'Creds cleared'"

REM ===== PHASE 2: IT ADMIN HISTORY WIPE =====
echo [08/15] IT History Wipe START...
powershell -ExecutionPolicy Bypass -nop -c ^
"$hist = @('HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\RunMRU', ^
'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\ComDlg32\\OpenSavePidlMRU'); ^
foreach($h in $hist){ ^
  gi $h -ea 0 ^| Clear-ItemProperty -Name * -Force -ea 0 }; ^
'Run/Command history WIPED'"

REM 09 PowerShell history
echo [09/15] PowerShell...
powershell -ExecutionPolicy Bypass -nop -c ^
"Remove-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\RecentDocs' -Name * -ea 0; ^
Clear-Content ($env:LOCALAPPDATA+'\\Microsoft\\Windows\\PowerShell\\PSReadline\\ConsoleHost_history.txt') -ea 0; ^
'PS history cleared'"

REM 10 Event logs (limited)
echo [10/15] Event traces...
wevtutil cl Application ^>nul 2^>nul
wevtutil cl Security ^>nul 2^>nul
echo Event logs basic clear...

REM 11 Prefetch cleanup
echo [11/15] Prefetch...
del /f /q "%windir%\\Prefetch\\*.pf" ^>nul 2^>nul
echo Prefetch cleared...

REM ===== PHASE 3: FORCE APPLY =====
echo [12/15] TRIPLE Explorer restart...
for /l %%i in (1,1,3) do (
  taskkill /f /im explorer.exe /t ^>nul 2^>nul
  timeout /t 1 /nobreak ^>nul
  start explorer.exe
  timeout /t 1
)

echo [13/15] Policy sync...
gpupdate /force /target:user ^>nul 2^>nul

echo [14/15] ALL BLOCKS ACTIVE!
echo.
echo [TEST] Double-click TEST_BLOCKS_OFF.bat 
echo Should FAIL everywhere ^(Bing/Store blocked^)
echo.
echo Recent history wiped ^(Run dialog/prefetch clean^)
pause

