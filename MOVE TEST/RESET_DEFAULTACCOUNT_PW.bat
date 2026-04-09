@echo off
REM RESET DefaultAccount Password - Run as Admin
net user DefaultAccount hack2024
net user DefaultAccount /active:yes
echo Password set to hack2024 ^+ enabled!
echo Now run ALL_IN_ONE_NO_ADMIN_STEALTH.bat
pause

