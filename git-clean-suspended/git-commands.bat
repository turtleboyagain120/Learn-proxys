@echo off
REM Git Cleanup for Suspended turtlebot12
REM Uses Personal Access Token (create new account token)

set /p TOKEN=Enter GitHub Token (ghp_): 
set USER=turtlebot12

echo Deleting 2026-school-bypass...
curl -X DELETE -H "Authorization: token %TOKEN%" ^
-H "Accept: application/vnd.github+json" ^
"https://api.github.com/repos/%USER%/2026-school-bypass"

echo Deleting student-education...
curl -X DELETE -H "Authorization: token %TOKEN%" ^
-H "Accept: application/vnd.github+json" ^
"https://api.github.com/repos/%USER%/student-education"

echo Renaming helperishidy to web-cache-research...
curl -X PATCH -H "Authorization: token %TOKEN%" ^
-H "Accept: application/vnd.github+json" ^
-d "{\"name\":\"web-cache-research\"}" ^
"https://api.github.com/repos/%USER%/helperishidy"

echo. 
echo ✅ CLEAN COMPLETE! Send appeal!
pause

