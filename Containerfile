# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG BASE_IMAGE
ARG DISTRO
ARG DISTRO_VARIANT

FROM ${BASE_IMAGE}:${DISTRO}_${DISTRO_VARIANT}

LABEL \
        org.opencontainers.image.title="Docker Socket Proxy" \
        org.opencontainers.image.description="Protect your docker socket with a HTTP barrier" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/nginx" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/docker-socket-proxy/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/docker-socket-proxy.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ENV \
        NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
        NGINX_ENABLE_CLIENT_CACHE=NONE \
        NGINX_SITE_ENABLED=docker-socket-proxy \
        NGINX_USER=root \
        NGINX_LISTEN_PORT=2375 \
        NGINX_LOG_ACCESS_FILE=access.log \
        NGINX_LOG_ACCESS_LOCATION=/logs \
        NGINX_LOG_BLOCKED_FILE=/null \
        NGINX_LOG_BLOCKED_LOCATION=/dev \
        NGINX_LOG_ERROR_FILE=error.log \
        NGINX_LOG_ERROR_LOCATION=/logs \
        NGINX_WORKER_PROCESSES=1 \
        IMAGE_NAME="nfrastack/docker-socket-proxy" \
        IMAGE_REPO_URL="https://github.com/nfrastack/docker-socket-proxy/"

RUN echo "" && \
    source /container/base/functions/container/build && \
    container_build_log image && \
    package update && \
    package upgrade && \
    package cleanup

COPY rootfs /
