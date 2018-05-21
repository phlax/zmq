# phlax/zmq
#
# VERSION       0.0.1

ARG BUILD_FROM=debian:stretch-slim

# Root stage shared by builder and app images
FROM $BUILD_FROM as root

MAINTAINER Ryan Northey <ryan@synca.io>
ENV DEBIAN_FRONTEND=noninteractive


ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000
ARG APP_USERNAME=zmq
ARG APP_DIR=/app


ENV DEBIAN_FRONTEND=noninteractive \
    APP_DIR=$APP_DIR \
    APP_USERNAME=$APP_USERNAME

COPY ./install /tmp/install
RUN /tmp/install/install.sh

# Build stage
FROM root as builder

ENV APP_PKG="aiozmq zope.dottedname msgpack"

COPY ./builder /tmp/build
RUN /tmp/build/build.sh

# App stage
FROM root

ENV PYTHONPATH=/app/src \
    APP_SERVER=

COPY ./create /tmp/create
RUN /tmp/create/create.sh

# the chown flag has to be hardcoded for now
COPY --chown=zmq:zmq --from=builder "$APP_DIR" "$APP_DIR"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/run-zmq"]
