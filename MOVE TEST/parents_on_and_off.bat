@echo off
REM ===== PARENTS ON/OFF ALL-IN-ONE =====
REM Kid-Proof Parental Toggle System
REM OFF: Double-click (no admin)
REM ON: Right-click Run as admin
title Parental Toggle Control Panel
color 0A
setlocal enabledelayedexpansion

:menu
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║        PARENTAL CONTROLS v2.0        ║  
echo  ║     Kid-Proof Toggle System         ║
echo  ╚══════════════════════════════════════╝
echo.
echo  [1] 🔓 TURN OFF Parental Controls (No Admin)
echo  [2] 🔒 TURN ON Parental Controls (Admin needed)  
echo  [3] 🧪 TEST Blocks Status
echo  [4] 📖 Kid-Proof Guide
echo  [0] ❌ Exit
echo.
set /p choice="Enter choice (0-4): "

if "!choice!"=="1" goto parental_off
if "!choice!"=="2" goto parental_on  
if "!choice!"=="3" goto test_blocks
if "!choice!"=="4" goto kid_guide
if "!choice!"=="0" exit /b
goto menu

:parental_off
cls
echo 🔓 MAXIMUM UNLOCK - No Admin Needed
echo [NUCLEAR Parental OFF - 40+ lines]
call ""%~dp0PARENTAL_OFF_NO_ADMIN.bat""
timeout /t 3
goto menu

:parental_on
cls
echo ⚠️  ADMIN REQUIRED - Right-click this file!
echo 🔒 MAXIMUM LOCKDOWN + History Wipe (120+ lines)
echo This WILL prompt UAC - normal!
msg * "Click YES for parental lockdown ^(safe^)"
call ""%~dp0PARENTAL_ON_EXTRA_SECURITY.bat""
timeout /t 3
goto menu

:test_blocks
cls
echo 🧪 TESTING BLOCK STATUS...
echo.
echo Opening test sites ^(Bing/Store^)...
start "" "microsoft-edge:https://www.bing.com"
powershell -Command "Start-Process ms-windows-store:"
timeout /t 5 /nobreak
echo.
echo ★ BING OPENED = Parental OFF ✓
echo ★ BING BLOCKED = Parental ON ✓
pause
goto menu

:kid_guide
cls
echo 📖 KID-PROOF GUIDE
echo.
echo  ╔═══════════════════════════════════╗
echo  ║      FOR PARENTS ONLY!            ║
echo  ╚═══════════════════════════════════╝
echo.
echo  OFF [1]: Kid can click - harmless
echo  ON  [2]: YOU run as admin → locks
echo  Test [3]: Shows if working
echo.
echo  Desktop greyscreen = NORMAL (3-5s)
echo  History auto-wiped on ON
echo.
pause
goto menu

