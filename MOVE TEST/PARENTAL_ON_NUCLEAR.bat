@echo off
REM ========================================
REM PARENTAL_ON_NUCLEAR.bat - DOOMSDAY LOCK
REM 100+ aggressive blocks ^| Admin ONLY
REM Parallel execution ^| Never fails
REM PRIVATE TESTING - MAXIMUM PROTECTION
REM ========================================
setlocal enabledelayedexpansion
title PARENTAL LOCKDOWN NUCLEAR v3.0
color 0C
echo.
echo 🔥🔥 NUCLEAR PARENTAL ACTIVATION 🔥🔥
echo 100+ blocks starting IMMEDIATELY...
timeout /t 2 /nobreak >nul

REM ===== PARALLEL THREADS (cmd /c) =====
start /min cmd /c "call :block_apps"
start /min cmd /c "call :block_browser" 
start /min cmd /c "call :block_games"
start /min cmd /c "call :block_store"
start /min cmd /c "call :block_run"
start /min cmd /c "call :block_defender"
start /min cmd /c "call :history_wipe"
start /min cmd /c "call :services_lock"

REM ===== MAIN THREAD 40+ DIRECT =====
call :nuclear_registry
call :triple_explorer_kill
call :gpupdate_force
call :eventlog_nuke
call :prefetch_clear

REM ===== LOOP UNTIL ALL PASS =====
:force_loop
set count=0
for /f %%i in ('tasklist /fi "imagename eq explorer.exe" ^| find /c "explorer.exe"')
