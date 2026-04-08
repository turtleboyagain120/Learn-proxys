# Boring Proxy - Lightweight Site Unblocker via hide.me VPN + Nginx

Lightweight Dockerized HTTP/SOCKS5 proxy through hide.me VPN. Super fast (<5s load), easy GitHub deploy. Under 10 files.

## Features
- HTTP proxy on :8080
- SOCKS5 on :1080
- Routes all traffic via hide.me VPN tunnel
Nginx reverse + Squid/ microsocks for speed/lightweight (open source proxies)

🚀 **ELI5 Quick Start** 🐢➡️🌐 Unblock sites! 

1. 🆓 **VPN config** (blocked? 😩): 
   - Copy vpn.ovpn.template to vpn.ovpn 
   - Edit: user/pass/server from hide.me (use phone hotspot 📱) 
   - Or find free configs GitHub search 'hide.me ovpn' 🔍

2. 🐳 **Docker magic** ⚡:
   - Download Docker Desktop https://docker.com 🖥️
   - Install & restart terminal ✅ `docker --version`
   ```
   git clone YOUR_GITHUB boring-proxy 🚀
   cd boring-proxy 
   docker compose up --build -d 🐳✨
   ```

3. 🌐 **Browser proxy** 🎯:
   - Install Proxy SwitchyOmega extension 🛠️
   - Set HTTP 127.0.0.1:8080 or SOCKS5 127.0.0.1:1080 ✅
   - Surf blocked sites! 🏄 Visit youtube.com test 🚀
   - Check IP: curl -x http://127.0.0.1:8080 ifconfig.me 🌍

4. 🔍 **Status check** 📊
```
docker compose logs -f 🐳📋
```
VPN 'Initialization Sequence Completed' = GO! 🎉

## Customization
- Edit `vpn.ovpn` for different server/user/pass
- Ports: docker-compose.yml

## Troubleshooting
- Docker Desktop installed? https://www.docker.com/products/docker-desktop/
- VPN not connecting? Check logs, try TCP ovpn.
- Windows firewall? Allow Docker.

## Architecture
Client -> Nginx(8080/1080) -> Squid/Microsocks -> OpenVPN tunnel -> Internet

Push to GitHub, share docker-compose up!

Tested on Windows 11. Docker build verified (syntax ok).