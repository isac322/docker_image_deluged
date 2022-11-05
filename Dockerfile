# syntax=docker/dockerfile:1.4

FROM python:3.10-alpine AS builder

ARG VERSION

RUN if ! [ "$(uname -m)" = 'x86_64' ]; then apk add --update libtorrent-rasterbar-dev geoip-dev gcc musl-dev libffi-dev; fi
RUN pip wheel -w /tmp/wheel deluge==${VERSION} libtorrent


FROM python:3.10-alpine
MAINTAINER 'Byeonghoon Isac Yoo <bhyoo@bhyoo.com>'
ENTRYPOINT ["/home/deluged/.local/bin/deluged"]
CMD ["--do-not-daemonize"]
RUN adduser deluged -D && apk add --update --no-cache libtorrent-rasterbar geoip && rm -rf /var/cache/apk
USER deluged
EXPOSE 58846 58846/UDP

RUN --mount=type=cache,target=/tmp/wheel,from=builder,source=/tmp/wheel \
    pip install --user --no-cache-dir --no-warn-script-location --no-index --compile /tmp/wheel/*.whl
