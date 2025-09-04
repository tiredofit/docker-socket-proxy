# nfrastack/docker-socket-proxy

## About

This repository will build a container to proxy your Docker Socket. It can help you put a layer of protection for applications needing to access the socket with limited scope or read only.

## Maintainer

- [Nfrastack](https://www.nfrastack.com)

## Table of Contents


- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Prebuilt Images](#prebuilt-images)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Core Configuration](#core-configuration)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
  - [Manual Definition Updates](#manual-definition-updates)
- [Support & Maintenance](#support--maintenance)
- [License](#license)

## Prerequisites and Assumptions

- You have access to your docker socket

## Installation

### Prebuilt Images
Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/docker-socket-proxy/pkgs/container/docker-socket-proxy) and [Docker Hub](https://hub.docker.com/r/nfrastack/socket-proxy).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/docker-socket-proxy:(image_tag)
docker.io/nfrastack/socket-proxy:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>-<optional_distribution>_<optional_distribution_variant>`

Example:

`ghcr.io/nfrastack/docker-socket-proxy:latest` or

`ghcr.io/nfrastack/docker-socket-proxy:1.0` or

`ghcr.io/nfrastack/docker-socket-proxy:1.0-alpine` or

`ghcr.io/nfrastack/docker-socket-proxy:alpine`

- `latest` will be the most recent commit
- An otpional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest
- If it is built for multiple distributions there may exist a value of `alpine` or `debian`
- If there are multiple distribution variations it may include a version - see the registry for availability

Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

- The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

- Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
- Set various [environment variables](#environment-variables) to understand the capabilities of this image.

Point your applications to to this new endpoint at http://(your_container_name:2375)

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory              | Description                     |
| ---------------------- | ------------------------------- |
| `/logs`                | Logfiles for Nginx              |
| `/var/run/docker.sock` | Connect your docker socket here |

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description |
| ------------------------------------------------------- | ----------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image  |

Below is the complete list of available options that can be used to customize your installation.

- Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Core Configuration

| Parameter           | Description                                                                            | Default                     | Advanced |
| ------------------- | -------------------------------------------------------------------------------------- | --------------------------- | -------- |
| `ALLOWED_IPS`       | Comma seperated list of IPs or networks that can access the endpoints                  | `0.0.0.0/0`                 |          |
| `DOCKER_SOCKET_URI` | How to connect to the docker socket inside the container                               | `unix:/var/run/docker.sock` |          |
| `ENABLE_READONLY`   | Enable Read Only Mode (`GET`) otherwise allow Read-Write(`GET POST`)                   | `TRUE`                      |          |
| `MODE`              | Proxying Mode - Allow access to endpoints                                              |                             |          |
|                     | Endpoint list:                                                                         |                             |
|                     | [https://docs.docker.com/engine/api/v1.41/](https://docs.docker.com/engine/api/v1.41/) |                             |          |
|                     | Pre Made:                                                                              |                             |
|                     | `NONE` (none at all), `DEFAULT` (events,ping,version), `ALL` (All of them)             |                             |          |
|                     | or individual endpoints, seperated by commas                                           | `DEFAULT`                   |          |
|                     | `AUTH` /auth                                                                           |                             |          |
|                     | `BUILD` /build                                                                         |                             |          |
|                     | `COMMIT` /commit                                                                       |                             |          |
|                     | `CONFIGS` /configs                                                                     |                             |          |
|                     | `CONTAINERS` /containers                                                               |                             |          |
|                     | `DISTRIBUTION` /distribution                                                           |                             |          |
|                     | `EVENTS` /events                                                                       |                             |          |
|                     | `EXEC` /exec                                                                           |                             |          |
|                     | `GRPC` /grpc                                                                           |                             |          |
|                     | `IMAGES` /images                                                                       |                             |          |
|                     | `INFO` /info                                                                           |                             |          |
|                     | `NETWORKS` /networks                                                                   |                             |          |
|                     | `NODES` /nodes                                                                         |                             |          |
|                     | `PING` /_ping                                                                          |                             |          |
|                     | `PLUGINS` /plugins                                                                     |                             |          |
|                     | `SECRETS` /secrets                                                                     |                             |          |
|                     | `SERVICES` /servics                                                                    |                             |          |
|                     | `SESSION` /session                                                                     |                             |          |
|                     | `SWARM` /swarm                                                                         |                             |          |
|                     | `SYSTEM` /system                                                                       |                             |          |
|                     | `TASKS` /tasks                                                                         |                             |          |
|                     | `VERSION` version                                                                      |                             |          |
|                     | `VOLUMES` /volumes                                                                     |                             |          |
| `TIMEOUT_CONNECT`   | Timeout for initial connection to docker socket                                        | `10s`                       |          |
| `TIMEOUT_READ`      | Read timeout to docker socket if no activity                                           | `86400s`                    |          |
| `TIMEOUT_SEND`      | Send timeout to docker socket if no activity                                           | `86400s`                    |          |

### Networking

| Port   | Protocol | Description       |
| ------ | -------- | ----------------- |
| `2375` | tcp      | Proxy listen port |

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

### Manual Definition Updates

Manual Definition Updates can be performed by entering the container and typing `update-now`

## Support & Maintenance

- For community help, tips, and community discussions, visit the [Discussions board](/discussions).
- For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
- To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
- Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
- Updates are best-effort, with priority given to active production use and support agreements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
