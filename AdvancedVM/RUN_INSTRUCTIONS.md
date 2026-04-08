# 🖥️ BlackBoxOS - ELI5 Run Guide (Emojis + Docker Fix!)

## 📦 Tools (Download like apps 🛠️)
1. 🐳 **Docker Desktop** → [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop) → Install → **Restart PC** → New terminal (fixes `'docker not found` 😤)
2. 🟢 **Node.js 20+** → [nodejs.org](https://nodejs.org) → Install
3. 🦀 **Rust** → [rustup.rs](https://rustup.rs) → Run `rustup-init.exe`
4. 🐍 **Python** → [python.org](https://python.org) → Install + check "Add to PATH"

**Terminal**: VSCode `Ctrl + `` 😎

## 🚀 Easy Docker (1 line)
```
cd "C:\Users\turtl\Desktop\AdvancedVM"; docker compose up --build
```
Wait 60s → Browser: **http://localhost:3000** → ✨ Holo OS live!

## 🖱️ Manual 3 Windows

**Option 1: 3 Terminals** (VSCode `Ctrl+Shift+`` new)

**Option 2: Start command (1 line opens 3 windows)**
```
start cmd /k "docker run -d --name blackbox-db -p 5432:5432 -e POSTGRES_DB=blackboxos -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=secret postgres:16" ^& start cmd /k "cd \"C:\Users\turtl\Desktop\AdvancedVM\vm-core\" ^& cargo run" ^& start cmd /k "cd \"C:\Users\turtl\Desktop\AdvancedVM\frontend\" ^& npm i ^& npm run dev"
```
Wait 30s → http://localhost:3000 🎉

*(Skip if Option 2 - already in MD above)*

**2. VM Brain 🧠** (Terminal 2 - `Ctrl+Shift+``):
```
cd "C:\Users\turtl\Desktop\AdvancedVM\vm-core"; cargo run
```
Wait "listening 8080" ✅

**3. UI 🌈** (Terminal 3):
```
cd "C:\Users\turtl\Desktop\AdvancedVM\frontend"; npm i; npm run dev
```
**http://localhost:3000** → Click icons 🧮🤖, type `ps`/`ls` in green shell 🎮

## 🎮 What happens?
- Shell commands: `ps` = processes list, `ls` = files 📜
- Icons pop alerts, glowy holo effects ✨
- All langs working (Rust VM, React UI, etc.)

## 😵 Fixes (Copy-paste errors)
| Error | Fix |
|-------|-----|
| `'docker' not found` | Docker install + restart PC/new terminal |
| `cargo not found` | rustup-init.exe + restart terminal |
| `npm not found` | Node install + restart |
| No UI? | Wait 1min, no red errors in terminals? |
| Kill DB | `docker stop/rm blackbox-db` |

**Boom! 🚀 VM OS running. No single file—it's a team of servers. Check RUN_INSTRUCTIONS.md anytime.**
