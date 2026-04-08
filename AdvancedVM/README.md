# BlackBoxOS - Super Advanced VM

Futuristic OS simulator in VM, using JS, Python, React/JSX, Rust, YAML, C/C#, SQL, Swift, Haskell, Java.

## Quick Start (Windows 11)
1. Install Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Open terminal at C:/Users/turtl/Desktop/AdvancedVM
3. `docker compose up --build`  (builds all services)
4. Open http://localhost:3000 - Interact with holographic desktop/shell!
5. Run VM cmds in shell: `ps`, `ls`, `ai hello`. All langs integrated.


## Architecture
- **UI**: React/JSX holographic desktop (localhost:3000)
- **VM Core**: Rust WebSocket server + C/C++ instr (localhost:8080)
- **DB**: Postgres SQL virtual FS/processes
- **Utils**: Python AI, Haskell pure func
- **Interop**: C#/Java/Swift app sims

## Develop
- Frontend: `cd frontend &amp;&amp; npm install &amp;&amp; npm start`
- Rust: `cd vm-core &amp;&amp; cargo run`
- Python: `cd utils &amp;&amp; pip install -r requirements.txt`

See implementation_plan.md for details.

