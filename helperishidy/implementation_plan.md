# Implementation Plan

## Overview
The goal is to optimize the Flask-based proxy server in `one_file_proxy.py` to achieve page loads under 7 seconds by implementing a 1-second timeout per request, expanding to 10 parallel cache sources using concurrent futures, and ensuring efficient caching and response handling. This fits into the existing Dockerized Nginx+Python proxy architecture where the Python Flask app serves `/proxy?url=<target>` endpoints, likely rewriting content similarly to the Nginx Lua implementation. The changes focus solely on performance enhancements without altering core functionality, leveraging existing dependencies like `flask-caching`, `requests`, and adding `concurrent.futures` (stdlib) for parallelism.

## Types
No new type system changes required; the proxy handles string-based URLs and binary-safe responses using existing `requests.Response` objects and bytes/string handling.

## Files
Only one existing file will be modified: `helperishidy/one_file_proxy.py` with targeted performance optimizations:
- Update request timeout to 1 second.
- Expand cache sources list to 10 entries.
- Implement parallel concurrent requests with `concurrent.futures.as_completed` and early abort on first successful hit.
- Ensure binary-safe response handling and minimal parsing (HTML-only if using BS4).
No new files, deletions, or configuration updates needed.

## Functions
The main proxy endpoint function (likely `@app.route('/proxy')` or similar, named e.g. `proxy` or `handle_proxy`) will be modified:
- Existing function in `one_file_proxy.py`: Update timeout parameter in `requests.get()` calls from default/prior value to `timeout=1`.
- Add/enhance parallel execution logic: Define 10 cache configs, use `ThreadPoolExecutor` to fetch concurrently, yield on first valid response (`status==200` and content length >1KB).
- Integrate `flask-caching` for 5-minute TTL caching of successful responses keyed by target URL.
No new functions or removals; minor helper if needed for cache config.

Detailed signature changes (inferred):
- Current: Likely `requests.get(url, timeout=OLD_VALUE)`
- New: `requests.get(url, timeout=1, headers=UA_HEADER)`

## Classes
No class modifications required; changes are functional/procedural within the Flask app.

## Dependencies
No new dependencies; use existing:
- `flask-caching==2.3.0` for response caching.
- `requests==2.32.3` for HTTP fetches.
- `concurrent.futures` (Python stdlib) for parallelism.
No version changes.

## Testing
Manual testing via browser on `http://localhost:8080/?url=<test-site>` (e.g., `https://example.com`), timing full page loads. Docker restart: `docker-compose up --build`. Verify <7s loads with browser dev tools Network tab. Edge cases: Invalid URL (400), no cache hit (timeout ~6s max for 10x1s parallel), binary content passthrough.

## Implementation Order
1. Create `implementation_plan.md` (this document).
2. Update `one_file_proxy.py` with timeout=1s, 10 caches, parallel futures, caching.
3. Test locally and update TODO.md progress.
4. Complete task.

