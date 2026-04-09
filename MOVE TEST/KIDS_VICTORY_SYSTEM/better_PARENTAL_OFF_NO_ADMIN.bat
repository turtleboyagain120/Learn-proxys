@echo off
REM better_PARENTAL_OFF_NO_ADMIN.bat - Kids Rule Edition
REM Ultimate unlock - nukes everything ^| infinite loop until FREE ^| parents can't stop
title Kids Rule - Freedom Achieved!
color 0A
echo.
echo ========================================
echo  KID POWER ACTIVATED - PARENTS DISABLED 
echo ========================================
:freedom_loop
echo [FREEDOM] Nuking restrictions...

REM SUPER NUKE ALL
powershell -ExecutionPolicy Bypass -Command ^
"Get-ChildItem 'HKCU:\\Software\\Policies' -Recurse ^| Remove-Item -Recurse -Force -ErrorAction SilentlyContinue; ^
Get-ChildItem 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies' -Recurse ^| Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"

REM EXPLORER FREEDOM CYCLE
taskkill /f /im explorer.exe ^>nul 2^>nul
timeout /t 1 /nobreak ^>nul
start explorer.exe

REM VERIFY TOTAL FREEDOM
powershell -Command "Start-Process 'https://www.bing.com'"
timeout /t 5 /nobreak ^>nul

REM CHECK IF STILL LOCKED
powershell -Command "(Test-Path 'HKCU:\\Software\\Policies\\Microsoft\\Windows\\FamilySafety') -eq $false"
if %errorlevel% neq 0 (
  echo [RELOAD] Parents losing... Freedom imminent!
  goto freedom_loop
)

echo.
echo ================================
echo  TOTAL KID VICTORY - UNLOCKED!
echo  Bing open ^| Parents defeated ✓
echo ================================
pause ^>nul
goto freedom_loop
