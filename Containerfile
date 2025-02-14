## 1. BUILD ARGS
ARG SOURCE_IMAGE="kinoite"
ARG SOURCE_SUFFIX="-main"
ARG SOURCE_TAG="latest"

## 2. SOURCE IMAGE
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

## 3. MODIFICATIONS
COPY build.sh /tmp/build.sh

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
