@echo off
REM Test if parental blocks OFF
echo === Test Bing/App Store ===
powershell -Command "Start-Process microsoft-edge:https://bing.com"
powershell -Command "Start-Process ms-windows-store:"
echo === Test Microsoft Store ===
timeout /t
