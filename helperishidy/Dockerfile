FROM openresty/openresty:alpine

# Install dependencies
RUN apk add --no-cache pcre-dev openssl-dev git bash wget

# Copy app
WORKDIR /usr/share/nginx/html
COPY index.html .

# Config
COPY nginx.conf /etc/nginx/nginx.conf

# Logs compat with compose volumes
RUN mkdir -p /var/log/nginx && chmod -R 777 /var/log/nginx

# Expose
EXPOSE 8080

# Healthcheck improved
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Runtime
CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]

