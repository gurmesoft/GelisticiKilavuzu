#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

if [ -d /var/www ]; then
  echo "[i] /var/www directory already contains files, making nginx the owner..."
  chown -R www-data:www-data /var/www
else
  echo "[i] /var/www directory not found, creating..."
  mkdir -p /var/www
  chown -R www-data:www-data /var/www
fi

if [ "$PS_INSTALL_AUTO" = "1" ]; then
  if [ -f "/tmp/prestashop.zip" ]; then
    echo "Prestashop daha önce indirilmis. Kurulum atlanıyor"
  else 
    echo "[i] Installing Prestashop...";
    wget "https://github.com/PrestaShop/PrestaShop/releases/download/1.7.7.8/prestashop_1.7.7.8.zip" -O /tmp/prestashop.zip
    unzip -n -q /tmp/prestashop.zip -d /tmp/prestashop/
    rm -rf /tmp/prestashop.zip
    unzip -n -q /tmp/prestashop/prestashop.zip -d /var/www
    rm -rf /tmp/prestashop/prestashop.zip
    chown -R nginx:nginx /var/www

    if [ $PS_FOLDER_INSTALL != "install" ]; then
      echo "\n* Renaming install folder to $PS_FOLDER_INSTALL ...";
      mv /var/www/install /var/www/$PS_FOLDER_INSTALL/
    fi

    if [ $PS_FOLDER_ADMIN != "admin" ]; then
      echo "\n* Renaming admin folder to $PS_FOLDER_ADMIN ...";
      mv /var/www/admin /var/www/$PS_FOLDER_ADMIN/
    fi
  fi
else
  echo "[i] Pretashop already installed...";
fi

echo "[i] Fixing permissions & ownership..."

find /var/www/ -type f -exec chmod 644 {} \; && find /var/www/ -type d -exec chmod 755 {} \;
chown -R www-data:www-data /var/www

echo "[i] Starting Prestashop..."