# Docker image preinstalled the Python package `deluge` (daemon only)

[1]: https://hub.docker.com/r/isac322/deluged
[2]: https://pypi.org/project/deluge/
[3]: https://github.com/isac322/docker_image_deluged

[![Docker Pulls](https://img.shields.io/docker/pulls/isac322/deluged?logo=docker&style=flat-square)][1]
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/isac322/deluged/latest?logo=docker&style=flat-square)][1]
[![PyPI](https://img.shields.io/pypi/v/deluge?label=deluge&logo=python&style=flat-square)][2]
[![GitHub last commit](https://img.shields.io/github/last-commit/isac322/docker_image_deluged/master?logo=github&style=flat-square)][3]
[![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/isac322/docker_image_deluged/publish?logo=github&style=flat-square)][3]
[![Dependabpt Status](https://flat.badgen.net/github/dependabot/isac322/docker_image_deluged?icon=github)][3]

> ### Images automatically follow upstream via dependabot.

Supported platform: `linux/amd64`, `linux/arm64/v8`

## Tag format

`isac322/deluged:<deluge_version>`

## Command

Default entrypoint of image is `deluged` and `--do-not-daemonize --port 58846 --ui-interface 0.0.0.0 --interface 0.0.0.0` for default command.

## How to run

`docker run -p 58846:58846 -ti isac322/deluged` will launch deluge daemon.
