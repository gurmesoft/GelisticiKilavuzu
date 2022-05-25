#!/bin/bash
# docker-entrypoint, supervisor starter

if [ "$1" = "--nginx-env" ]; then

	cd /var/www;
    wp install --dbpass=${WORDPRESS_PASS}
fi
