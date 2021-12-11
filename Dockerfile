FROM wiserain/libtorrent:2.0.5-alpine3.14 AS builder

COPY requirements.txt /tmp
RUN apk add --no-cache gcc git libffi-dev cargo zlib-dev jpeg-dev openssl-dev py3-pip py3-wheel python3-dev \
    && pip wheel --no-cache-dir -r /tmp/requirements.txt --wheel-dir /tmp/wheels

FROM alpine:3.15.0
MAINTAINER 'Byeonghoon Isac Yoo <bh322yoo@gmail.com>'
ENTRYPOINT ["/home/deluged/.local/bin/deluged"]
EXPOSE 58846 58846/UDP
WORKDIR /home/deluged

COPY --from=builder /tmp/wheels /tmp/wheels
COPY --from=builder /libtorrent-build /
RUN adduser deluged -D  \
    && apk add --no-cache boost-python3 py3-pip py3-wheel \
    && su - deluged -c 'pip install --force-reinstall --no-warn-script-location --no-cache-dir --no-deps /tmp/wheels/*.whl'  \
    && rm -rf /tmp \
    && apk del py3-pip py3-wheel
USER deluged
