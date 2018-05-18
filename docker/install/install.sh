#!/bin/bash

# Installs/configures the packages used in all images
# and creates the pootle user

set -e

apt-get update -qq
apt-get install \
   -y \
   -qq \
   --no-install-recommends \
   locales \
   python-minimal \
   virtualenv
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8
useradd \
    -m \
    -u $APP_USER_ID \
    -d /home/$APP_USERNAME \
    -k /etc/skel \
    -s /bin/bash \
  $APP_USERNAME

echo "creating app dir: $APP_DIR"
mkdir -p "$APP_DIR"
chown -R $APP_USERNAME:$APP_USERNAME "$APP_DIR"

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
apt-get clean
