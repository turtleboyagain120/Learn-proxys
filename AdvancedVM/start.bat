@echo off
title BlackBoxOS Starter
echo Starting BlackBoxOS VM - Open multiple terminals...

REM Ensure in project
cd /d "C:\Users\turtl\Desktop\AdvancedVM"

REM 1. DB (Postgres container)
echo Starting DB...
start "DB" cmd /k "docker run -d --name blackbox-db -p 5432:5432 -v db_data:/var/lib/postgresql/data -e POSTGRES_DB=blackboxos -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=secret postgres:16"

REM Wait
timeout /t 10 /nobreak >nul

REM 2. Rust VM
echo Starting VM core...
start "VM" cmd /k "cd vm-core && cargo run"

REM Wait
timeout /t 5 /nobreak >nul

REM 3. Frontend
echo Starting UI...
start "UI" cmd /k "cd frontend && npm install && npm run dev"

REM 4. Python utils
start "Utils" cmd /k "cd utils && pip install -r requirements.txt && python ai_assistant.py"

echo.
echo BlackBoxOS running!
echo - UI: http://localhost:3000
echo -
