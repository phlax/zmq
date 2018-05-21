#!/bin/bash

# Installs/configures the packages used in all images
# and creates the pootle user

set -e

apt-get update -qq
apt-get install \
   -y \
   -qq \
   --no-install-recommends \
   git \
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
mkdir -p "$APP_DIR/src"
chown -R $APP_USERNAME:$APP_USERNAME "$APP_DIR"

su - $APP_USERNAME bash -c "\
   cd $APP_DIR \
   && virtualenv -p /usr/bin/python3 . \
   && . bin/activate \
   && cd src \
   && git clone https://github.com/phlax/ctrl.core \
   && git clone https://github.com/phlax/ctrl.config \
   && git clone https://github.com/phlax/ctrl.command \
   && git clone https://github.com/phlax/ctrl.zmq \
   && cd ctrl.core \
   && pip install -e . \
   && cd ../ctrl.command \
   && pip install -e . \
   && cd ../ctrl.config \
   && pip install -e . \
   && cd ../ctrl.zmq \
   && pip install -e ."

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
apt-get clean
