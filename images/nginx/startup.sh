#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/certificates/default.key" 2048
    openssl req -new -key "/etc/nginx/certificates/default.key" -out "/etc/nginx/certificates/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/certificates/default.csr" -signkey "/etc/nginx/certificates/default.key" -out "/etc/nginx/certificates/default.crt"
    chmod 644 /etc/nginx/certificates/default.key
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
