#!/bin/bash

export HOME=/home/$APP_USERNAME

mkdir -p /app/sockets
mkdir -p /sockets

chown $APP_USERNAME:$APP_USERNAME /app/sockets
chown $APP_USERNAME:$APP_USERNAME /sockets

exec gosu $APP_USERNAME "$@"
