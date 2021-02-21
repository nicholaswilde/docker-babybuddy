# Docker Baby Buddy
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/babybuddy)](https://hub.docker.com/r/nicholaswilde/babybuddy)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/babybuddy)](https://hub.docker.com/r/nicholaswilde/babybuddy)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-babybuddy)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-babybuddy/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-babybuddy/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-babybuddy/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-babybuddy/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A multi-architecture image for [Baby Buddy](https://github.com/babybuddy/babybuddy).

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

| user | uid |
|:----:|:---:|
| abc  | 911 |

### docker-compose

* [sqlite](./docker-compose.sqlite.yaml)
* [postgres](./docker-compose.postgres.yaml)

## Development

See [Wiki](https://github.com/nicholaswilde/docker-template/wiki/Development).

## Troubleshooting

See [Wiki](https://github.com/nicholaswilde/docker-template/wiki/Troubleshooting).

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
