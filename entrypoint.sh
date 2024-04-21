#!/bin/sh
set -e

rm -f /run/dhclient.pid
dhclient

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- entrypoint-user.sh "$@"
fi

if [ "$1" = 'entrypoint-user.sh' ]; then
	chown steam:steam /dev/dri/*
	chown steam:steam /dev/snd/*
	chmod go+rw /dev/dri/*

	exec gosu steam "$@"
fi

exec "$@"
