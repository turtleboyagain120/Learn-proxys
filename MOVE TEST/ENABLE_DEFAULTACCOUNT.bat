@echo off
REM Enable DefaultAccount - RUN AS ADMIN FIRST
echo Enabling DefaultAccount...
net user DefaultAccount /active:yes
net user DefaultAccount hack2024
echo Enabled ^+ password set!
echo Now run STEALTH_DEFAULTACCOUNT_NO_ADMIN.ps1 as normal user.
pause
