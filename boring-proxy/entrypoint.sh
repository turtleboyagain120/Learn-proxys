#!/bin/sh

# Start OpenVPN
openvpn --config /etc/openvpn/vpn.ovpn --daemon --log /var/log/openvpn.log

# Wait for VPN to connect
while ! ip link show tun0 >/dev/null 2>&1; do
  sleep 1
done

ip route replace default dev tun0 metric 10 || true
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -w 5 -t nat -A POSTROUTING -o tun0 -j MASQUERADE || true

sleep 2

# Configure privoxy for HTTP proxy over VPN
squid -f /etc/squid/squid.conf -NYCd 1 &

# Start microsocks SOCKS5 server, bind to tun0 ip or all (routes via VPN)
microsocks -i 0.0.0.0 -p 1081 &

# Start nginx
nginx -g 'daemon off;'

