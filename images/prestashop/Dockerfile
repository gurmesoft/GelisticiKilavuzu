# GurmeSoft Wordpress
FROM gurmesoft/nginx-php7.4

ENV REPO="https://github.com/PrestaShop/PrestaShop" \
    SSH_PRIVATE_KEY="" \
    URL="localhost" \
    PS_FOLDER_ADMIN="admin" \
    PS_FOLDER_INSTALL="install" \
    PS_INSTALL_AUTO="1" \
    PS_ERASE_DB="0" \
    PS_INSTALL_GIT="0" \
    CLOUDFLARE_CDN="0" \
    DEV_MODE="0"

ADD files/run.sh /
RUN chmod +x /run.sh

# expose
EXPOSE 443

WORKDIR "/var/www"

# entrypoint  "/root/first-init"

CMD ["/run.sh"]
