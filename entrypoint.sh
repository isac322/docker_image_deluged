#!/usr/bin/env sh

set -ex

addgroup -g "${DELUGED_GID}" "${DELUGED_USER}"
adduser --disabled-password -s /sbin/nologin -G "${DELUGED_USER}" "${DELUGED_USER}"

mkdir -p /home/"${DELUGED_USER}"/.config/deluge
chown -R "${DELUGED_USER}":"${DELUGED_USER}" /home/"${DELUGED_USER}"/.config

# shellcheck disable=SC2068
exec deluged $@
