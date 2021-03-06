# Docker Baby Buddy
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/babybuddy)](https://hub.docker.com/r/nicholaswilde/babybuddy)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/babybuddy)](https://hub.docker.com/r/nicholaswilde/babybuddy)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-babybuddy)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-babybuddy/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-babybuddy/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-babybuddy/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-babybuddy/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

:no_entry:&nbsp; DEPRECATED A multi-architecture image for [Baby Buddy](https://github.com/babybuddy/babybuddy).

This image has been depcrecated. Please use the [linuxserver.io version](https://github.com/linuxserver/docker-babybuddy) instead.

## Dependencies

* sqlite
* postgres (optional)

## Usage

### docker cli

#### sqlite

```bash
$ docker run -d \
  --name=babybuddy \
  -e ALLOWED_HOSTS=* \                `# comma separated list of IP addresses or hosts that can access the web UI`
  -e DJANGO_SETTINGS_MODULE=babybuddy.settings.base
  -e SECRET_KEY="password" \          `# Generate a random string here to secure the Django instance`
  -e TIME_ZONE=America/Los_Angeles \  `# In the tzdata format, IE, "America/Denver"`
  -e DEBUG=False \                    `# Turn to False in production`
  -p 8000:8000 \
  --restart unless-stopped \
  nicholaswilde/babybuddy
```

### docker-compose

* [sqlite](./docker-compose.sqlite.yaml)
* [postgres](./docker-compose.postgres.yaml)

## Configuration

### Login

| default user | password |
|:----:|:---:|
| admin  | admin |

### Volumes

| user | uid |
|:----:|:---:|
| abc  | 911 |

```shell
$ chown -R 911:911 ./data
```

## Development

See [docs](https://nicholaswilde.io/docker-docs/development).

> **Note:** This image can't be pushed to the image registries using github-actions because it takes too long to build and timeouts.

## Troubleshooting

See [docs](https://nicholaswilde.io/docker-docs/troubleshooting).

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
$ pre-commit install
$ pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2021 by [Nicholas Wilde](https://github.com/nicholaswilde/).
