@echo off
REM FINAL Launcher - Double-click to run stealth DefaultAccount setup
REM Opens CMD + runs STEALTH.ps1 ^(no-admin, FamilySafety bypass^)

echo Starting in proper CMD...
cd /d "c:\Users\turtl\MOVE TEST"
cmd /k "PowerShell -ExecutionPolicy Bypass -File .\STEALTH_DEFAULTACCOUNT_NO_ADMIN.ps1 ^& echo Press any key to close... ^& pause"


