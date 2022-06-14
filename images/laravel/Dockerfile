# OS alpine 3.13
FROM gurmesoft/nginx-php7.4

COPY nginx-sites.conf /etc/nginx/sites-enabled/default
RUN cd /var/www; composer create-project laravel/laravel=8.6.12 .
RUN yarn global add @vue/cli
