# OS alpine 3.13
FROM nginx:1.19.8-alpine

# alpine & nginx version
RUN cat /etc/os-release | grep PRETTY_NAME && nginx -v

# build arguments
ARG timezone="Europe/Istanbul"

# packages
RUN apk update && apk add --no-cache \
    bash \
    openssh-client \
    openssl \
    supervisor \
    tzdata \
    gettext \
    curl \
    git \
    nodejs\
    yarn \
    # php
    php7 \
    php7-curl \
    php7-dom \
    php7-fileinfo \
    php7-xmlwriter \
    php7-fpm \
    php7-gd \
    php7-gettext \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-pdo \
    php7-phar \
    php7-psr \
    php7-pdo_mysql \
    php7-mysqli \
    php7-opcache \
    php7-session \
    php7-simplexml \
    php7-tokenizer \
    php7-xdebug \
    php7-pecl-xdebug \
    php7-xml \
    php7-zlib \
    && rm -rf /var/cache/apk/*

# directory links
RUN ln -sf /etc/php7 /etc/php && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
    ln -sf /usr/lib/php7 /usr/lib/php

# timezone
ENV TZ=$timezone \
    COMPOSER_ALLOW_SUPERUSER=1

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && date

# php composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# set www-data group (82 is the standard uid/gid for www-data in Alpine)
RUN set -x; \
    addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data; \
    adduser -D -S -G www-data -s /bin/ash vscode && exit 0; exit 1


# prepare folders
RUN rm /etc/nginx/conf.d/default.conf && \
    mkdir -p /var/www/public /var/log/supervisord

RUN chmod -R 775 /var/www; chown vscode -R /var/www 

ADD ../../cert /cert
# copy files
COPY bashrc /root/.bashrc
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-sites.conf /etc/nginx/sites-enabled/default
COPY cert/rootCA.pem /root/cert
COPY cert/rootCA.key /root/cert
COPY cert/server.csr /root/cert

COPY ssl/localhost.pem /etc/nginx/certificates/localhost.pem 
COPY nginx-sites.conf /etc/nginx/sites-enabled/default
COPY php-fpm.conf /etc/php7/php-fpm.d/www.conf
COPY xdebug.ini /etc/php/conf.d
COPY index.php /var/www/public
COPY start /root/start

RUN openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout /etc/nginx/certificates/localhost.key \
    openssl x509 -req -in /root/cert/server.csr -CA /root/cert/rootCA.pem -CAkey /root/cert/rootCA.key -CAcreateserial -out /etc/nginx/certificates/localhost.crt -days 1000 -sha256 -extfile /root/cert/v3.ext \
    chmod 644 /etc/nginx/certificates/localhost.key \
    rm -rf /root/cert
# expose
EXPOSE 443


WORKDIR "/var/www"

# entrypoint  "/root/first-init"

ENTRYPOINT ["/root/start"]

