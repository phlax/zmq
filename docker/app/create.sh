#!/bin/sh


apt-get update -qq
apt-get install \
   -y \
   -qq \
   --no-install-recommends \
   gosu

cp -a /tmp/app/entrypoint.sh /usr/local/bin/entrypoint.sh
cp -a /tmp/app/run-zmq /usr/local/bin/run-zmq
mkdir /app/sockets
chown -R zmq:zmq /app/sockets
