# github.com/tiredofit/docker-socket-proxy

[![GitHub release](https://img.shields.io/github/docker-socket-proxy/tag/tiredofit/socket-proxy?style=flat-square)](https://github.com/tiredofit/docker-socket-proxy/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-socket-proxy/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-socket-proxy/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/dockersocket-proxy.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/socket-proxy/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/socket-proxy.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/socket-proxy/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker Image to proxy your [Docker](https://docker.com) socket. Don't let applications interface directly with it, scope their access!


## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)

## Prerequisites and Assumptions
-  You have access to your docker socket

## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/socket-proxy)

```bash
docker pull docker.io/tiredofdit/socket-proxy:(imagetag)
```
Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-socket-proxy/pkgs/container/docker-socket-proxy) 
 
```
docker pull ghcr.io/tiredofit/docker-socket-proxy/pkgs/container/docker-socket-proxy):(imagetag)
``` 

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for development or production use.

* Setup any networking to allow for exposing the listening port.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

Point your applications to to this new endpoint at http://(your_container_name:2375)

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory              | Description                     |
| ---------------------- | ------------------------------- |
| `/logs`                | Logfiles for Nginx              |
| `/var/run/docker.sock` | Connect your docker socket here |

* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)    | Nginx webserver                        |

| Variable            | Description                                                                                           | Default                     |
| ------------------- | ----------------------------------------------------------------------------------------------------- | --------------------------- |
| `ALLOWED_IPS`       | Comma seperated list of IPs or networks that can access the endpoints                                 | `0.0.0.0/0`                 |
| `DOCKER_SOCKET_URI` | How to connect to the docker socket inside the container                                              | `unix:/var/run/docker.sock` |
| `ENABLE_READONLY`   | Enable Read Only Mode (`GET`) otherwise allow Read-Write(`GET POST`)                                  | `TRUE`                      |
| `MODE`              | Proxying Mode - Allow access to endpoints                                                             |                             |
|                     | Endpoint list: [https://docs.docker.com/engine/api/v1.41/](https://docs.docker.com/engine/api/v1.41/) |                             |
|                     | Pre Made: `NONE` (none at all), `DEFAULT` (events,ping,version), `ALL` (All of them)                  |                             |
|                     | or individual endpoints, seperated by commas                                                          | `DEFAULT`                   |
|                     | `AUTH` /auth                                                                                          |                             |
|                     | `BUILD` /build                                                                                        |                             |
|                     | `COMMIT` /commit                                                                                      |                             |
|                     | `CONFIGS` /configs                                                                                    |                             |
|                     | `CONTAINERS` /containers                                                                              |                             |
|                     | `DISTRIBUTION` /distribution                                                                          |                             |
|                     | `EVENTS` /events                                                                                      |                             |
|                     | `EXEC` /exec                                                                                          |                             |
|                     | `GRPC` /grpc                                                                                          |                             |
|                     | `IMAGES` /images                                                                                      |                             |
|                     | `INFO` /info                                                                                          |                             |
|                     | `NETWORKS` /networks                                                                                  |                             |
|                     | `NODES` /nodes                                                                                        |                             |
|                     | `PING` /_ping                                                                                         |                             |
|                     | `PLUGINS` /plugins                                                                                    |                             |
|                     | `SECRETS` /secrets                                                                                    |                             |
|                     | `SERVICES` /servics                                                                                   |                             |
|                     | `SESSION` /session                                                                                    |                             |
|                     | `SWARM` /swarm                                                                                        |                             |
|                     | `SYSTEM` /system                                                                                      |                             |
|                     | `TASKS` /tasks                                                                                        |                             |
|                     | `VERSION` version                                                                                     |                             |
|                     | `VOLUMES` /volumes                                                                                    |                             |
| `TIMEOUT_CONNECT`   | Timeout for initial connection to docker socket                                                       | `10s`                       |
| `TIMEOUT_READ`      | Read timeout to docker socket if no activity                                                          | `3600s`                     |
| `TIMEOUT_SEND`      | Send timeout to docker socket if no activity                                                          | `3600s`                     |

### Networking
| Port   | Protocol | Description   |
| ------ | -------- | ------------- |
| `2375` | `tcp`    | Docker Socket |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

