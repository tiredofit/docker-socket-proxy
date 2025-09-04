ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.20

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}

LABEL org.opencontainers.image.title         "Docker Socket Proxy"
LABEL org.opencontainers.image.description   "Dockerized Socket Proxy based on Nginx"
LABEL org.opencontainers.image.url           "https://hub.docker.com/r/tiredofit/socket-proxy"
LABEL org.opencontainers.image.documentation "https://github.com/tiredofit/docker-socket-proxy/blob/main/README.md"
LABEL org.opencontainers.image.source        "https://github.com/tiredofit/docker-socket-proxy.git"
LABEL org.opencontainers.image.authors       "Dave Conroy <dave@tiredofit.ca>"
LABEL org.opencontainers.image.vendor        "Tired of I.T! <https://www.tiredofit.ca>"
LABEL org.opencontainers.image.licenses      "MIT"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

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

    RUN echo "" && \
    source /container/base/functions/container/build && \
    container_build_log && \
    package update && \
    package upgrade && \
    package cleanup

COPY rootfs /
