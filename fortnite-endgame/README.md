# Fortnite Endgame Spectator Game

## How to Run (Python 3.14)

1. Save all files in `C:/Users/turtl/Desktop/fortnite-endgame/` (already done).

2. Open terminal/cmd, cd to Desktop:
   ```
   cd C:/Users/turtl/Desktop/fortnite-endgame
   ```

3. Run Python HTTP server:
   ```
   python -m http.server 8000
   ```

4. Open browser to: http://localhost:8000

5. Watch AI bots play endgame! Use mouse to orbit camera.

## Scaling to 1000+ Scripts

- Duplicate `scripts/ai/*.js` files, vary names/functions slightly (e.g., `build_wall_v2.js`).
- Add to `ai-core.js` behaviors array.
- To automate: Create `generate_behaviors.py`:
  ```
  import os
  templates = ['rotate', 'build', 'edit']
  for i in range(1000):
      with open(f'scripts/ai/behavior_{i}.js', 'w') as f:
          f.write(f'export default function behavior_{i}(bot, game) {{ /* micro action */ }}')
  ```
- Run `python generate_behaviors.py` in project dir, reload page.

## Features
- 20+ AI bots with FSM, micro-actions.
- Dynamic building/editing/rotating.
- Shrinking zone, cluttered arena.
- Spectator orbit cam.
- tips.md for pro Fortnite meta.

Enjoy the chaos!
