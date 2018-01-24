#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- grlc_oneshot "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'grlc_oneshot' -a "$(id -u)" = '0' ]; then
	chown -R garlicoin .
	exec gosu garlicoin "$0" "$@"
fi

exec "$@"

