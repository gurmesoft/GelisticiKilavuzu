# GurmeSoft Wordpress
FROM gurmesoft/nginx-php7.4

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-sites.conf /etc/nginx/sites-enabled/default
COPY php-fpm.conf /etc/php7/php-fpm.d/www.conf

RUN rm -rf /var/www/*
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;\
    chmod +x wp-cli.phar;\
    mv wp-cli.phar /usr/local/bin/wp
RUN cd /var/www;wp core download;
COPY wp-config-docker.php /var/www/wp-config.php
COPY .htaccess /var/www/.htaccess
RUN chown -R www-data:www-data /var/www

# expose
EXPOSE 443

WORKDIR "/var/www"

# entrypoint  "/root/first-init"

ENTRYPOINT ["/root/start"]

