#!/bin/sh


apt-get update -qq
apt-get install \
   -y \
   -qq \
   --no-install-recommends \
   gosu

cp -a /tmp/create/entrypoint.sh /usr/local/bin/entrypoint.sh
cp -a /tmp/create/run-zmq /usr/local/bin/run-zmq
