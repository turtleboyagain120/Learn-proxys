FROM nginx:alpine

RUN apk add --no-cache openvpn squid microsocks iptables iproute2 && \
    mkdir -p /etc/openvpn /etc/squid /run/openvpn

COPY nginx.conf /etc/nginx/nginx.conf
COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080 1080

ENTRYPOINT ["/entrypoint.sh"]

