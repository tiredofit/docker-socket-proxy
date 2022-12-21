ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.17

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
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
    IMAGE_NAME="tiredofit/docker-socket-proxy" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-socket-proxy/"

RUN source assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package cleanup

COPY install /
