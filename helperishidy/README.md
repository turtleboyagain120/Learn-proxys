# 🥇 Helperishidy - Easy School Bypass Proxy (Noob-Friendly Setup!)

## Overview
Multi-cache stealth proxy (Google/Bing/Archive/Perplexity chains). Python Flask dev + Nginx/OpenResty prod. <8s latency, full rewrite, Docker-ready.

**Features post-improvements**:
- Parallel cache fetch + fallback
- Smart rewrite (HTML/JS/CSS/forms/images)
- MIME-aware handling (js/css/yaml/bat/java/c/cpp)
- Strict URL validation (http/s only)
- Rate limiting, caching, HTTPS redirect
- Docker Compose: nginx+python+logs/volumes

## 🚀 Super Easy Setup (Noob Mode)

### Option 1: Python (5 mins, no Docker needed)
1. Open PowerShell/Command Prompt
2. `cd C:\Users\turtl\Desktop\helperishidy`
3. `pip install -r requirements.txt`
4. `python one_file_proxy.py`
5. Browser: http://localhost:5000/?url=https://youtube.com (enter any URL!)

**Stop:** Ctrl+C

### Option 2: Docker (Prod, copy-paste ready)
1. Install Docker Desktop from docker.com (free, Windows installer)
2. Restart PC if needed
3. `cd C:\Users\turtl\Desktop\helperishidy`
4. `docker compose up --build -d`
5. Browser: http://localhost:8080/?url=https://example.com (Nginx stealth!)

**Logs:** `docker compose logs -f`  
**Stop:** `docker compose down`





## Architecture
- **Python**: Flask on 5000 (dev/debug)
- **Nginx/OpenResty**: Lua proxy on 8080 (prod/stealth), serves index.html
- Caches: Google cache, Bing cc, Archive.ph, Perplexity (parallel <8s)

## Security
- URL validation (no javascript: data:)
- Rate limit 10/min/IP
- CSP headers
- No outbound non-cache

## Tests
```bash
pip install pytest
pytest tests/
```

Enjoy bypassing! 🚀😈

