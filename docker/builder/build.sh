#!/bin/bash

set -e

APP_DIR=$(readlink -f --canonicalize $(eval echo $APP_DIR))


echo "Installing package: $APP_PKG into $APP_DIR"
cd $APP_DIR
virtualenv -p /usr/bin/python3 .
. bin/activate \
    && pip install \
           -q \
           --no-cache-dir \
           --process-dependency-links \
           $APP_PKG \
    && pyclean .
