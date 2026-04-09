@echo off
REM better_PARENTAL_ON_NO_ADMIN.bat - Kids Rule Weak Lock
REM Fake lock that kids laugh at - auto-defeats after 30s
title Kids Rule - Fake Lock ^(30s timeout)
color 0C
echo.
echo [FAKE LOCK] Parents think they're in control...
timeout /t 30 /nobreak ^>nul
echo [KID WIN] Auto-unlock activated!
call better_PARENTAL_OFF_NO_ADMIN.bat

