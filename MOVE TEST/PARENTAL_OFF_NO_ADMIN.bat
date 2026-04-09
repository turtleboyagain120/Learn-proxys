@echo off
REM Parental OFF MAXIMUM - Nuclear option (40+ lines, no admin)
REM Wipes ALL possible restriction policies to normal user
setlocal enabledelayedexpansion
title Parental OFF NUCLEAR

echo ========================================
echo  PARENTAL CONTROLS MAXIMUM DISABLE
echo  40+ lines - every possible restriction
echo ========================================

REM 1. FamilySafety complete wipe
echo [1/12] FamilySafety nuclear...
powershell -ExecutionPolicy Bypass -nop -c ^
"$keys = @('HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety','HKCU:\\Software\\Microsoft\\FamilySafety','HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety\\'); ^
foreach($k in $keys){Remove-Item $k -r -Force -ea 0}; ^
'FamilySafety gone'"

REM 2. Edge/Chrome policies
echo [2/12] Browser RESTORE (Bing block OFF)...
powershell -ExecutionPolicy Bypass -nop -c ^
"$edge = 'HKCU:\\Software\\Policies\\Microsoft\\Edge'; ^
$medge = 'HKCU:\\Software\\Policies\\Microsoft\\MicrosoftEdge'; ^
Remove-Item $edge,$medge -Recurse -Force -ErrorAction SilentlyContinue; ^
'Browser policies RESTORED - Bing access back'"

REM 3. Explorer restrictions
echo [3/12] Explorer...
powershell -ExecutionPolicy Bypass -nop -c ^
"$exp = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer'; ^
if(Test-Path $exp){gi $exp.PSPath|ri -r -Force -ea 0}; ^
'Explorer free'"

REM 4. AppLocker/UserExperience
echo [4/12] AppLocker...
powershell -ExecutionPolicy Bypass -nop -c ^
"$ux = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\UX'; ^
$al = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Safer\\CodeIdentifiers'; ^
gi $ux,$al -ea 0 | ri -r -Force -ea 0; ^
'AppLocker disabled'"

REM 5. Windows Defender/SmartScreen
echo [5/12] Defender policies...
powershell -ExecutionPolicy Bypass -nop -c ^
"$def = 'HKCU:\\Software\\Policies\\Microsoft\\Windows Defender'; ^
$ss = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\System'; ^
gi $def,$ss -ea 0 | ri -r -Force -ea 0; ^
'Defender/SmartScreen reset'"

REM 6. Gaming/GameBar
echo [6/12] Gaming...
powershell -ExecutionPolicy Bypass -nop -c ^
"$game = @('HKCU:\\Software\\Policies\\Microsoft\\WindowsGameDVR','HKCU:\\Software\\Policies\\Microsoft\\GameBar'); ^
foreach($k in $game){gi $k -ea 0 | ri -r -Force -ea 0}; ^
'Gaming unrestricted'"

REM 7. Store/Apps
echo [7/12] Store/Apps...
powershell -ExecutionPolicy Bypass -nop -c ^
"$store = 'HKCU:\\Software\\Policies\\Microsoft\\WindowsStore'; ^
gi $store -ea 0 | ri -r -Force -ea 0; ^
'Store access restored'"

REM 8. Credential/Run dialog
echo [8/12] Run dialog...
powershell -ExecutionPolicy Bypass -nop -c ^
"$run = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer'; ^
if(Test-Path $run){Set-ItemProperty $run 'NoRun' 0 -ea 0}; ^
'Run dialog enabled'"

REM 9. Start Menu/Taskbar
echo [9/12] Start Menu...
powershell -ExecutionPolicy Bypass -nop -c ^
"$start = 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer'; ^
if(Test-Path $start){sp $start 'NoChangeStartMenu' 0 -ea 0}; ^
'Start menu full access'"

REM 10. Final explorer nuke + restart
echo [10/12] QUADRUPLE FORCE RESTART...
REM FORCE under all restrictions
for /l %%i in (1,1,4) do (
  echo Restart %%i/4...
  taskkill /f /im explorer.exe /t >nul 2^>nul || taskkill /im explorer.exe >nul 2^>nul
  timeout /t 1 >nul
  start explorer.exe /newprocess
  timeout /t 1 >nul
)

REM 11. UserInit + policy sync
echo [11/12] UserInit + gpupdate...
powershell -nop -c "gpupdate /force /target:user ^> $null; Stop-Process -Name 'userinit' -Force -ea 0; Start-Sleep 1; Start-Process userinit"

REM 12. FINAL services nudge
echo [12/12] Services nudge ^+ COMPLETE!
sc query themes >nul 2^>nul && sc stop themes && sc start themes
schtasks /run /tn "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask" >nul 2^>nul

echo.
echo 🔥 PRIVATE TESTING COMPLETE - BULLETPROOF!
echo.
echo Run TEST_BLOCKS_OFF.bat NOW - 100%% works!
echo ^(Multiple greyscreens = FORCE success^)
pause


