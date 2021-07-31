# Docker image preinstalled the Python package `deluge` (daemon only)

![Docker Pulls](https://img.shields.io/docker/pulls/isac322/deluged?logo=docker&style=flat-square)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/isac322/deluged/latest?logo=docker&style=flat-square)
![PyPI](https://img.shields.io/pypi/v/deluge?label=deluge&logo=python&style=flat-square)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/isac322/docker_image_deluged/master?logo=github&style=flat-square)
![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/isac322/docker_image_deluged/ci/master?logo=github&style=flat-square)
![Dependabpt Status](https://flat.badgen.net/github/dependabot/isac322/docker_image_deluged?icon=github)

Supported platform: `linux/amd64`, `linux/arm64/v8`, `linux/arm/v7`

## Tag format

`isac322/deluged:<deluge_version>`

## Command

Default Entrypoint of image is `deluged` and no default for command.

## How to run

`docker run -p 58846:58846 -ti isac322/deluged` will launch deluge daemon. You can append ` -d` to prevent daemonize.
