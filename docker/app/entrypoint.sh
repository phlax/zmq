#!/bin/bash

export HOME=/home/$APP_USERNAME

chown $APP_USERNAME:$APP_USERNAME /app/sockets

exec gosu $APP_USERNAME "$@"
