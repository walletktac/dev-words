#!/usr/bin/env sh
set -e
host="$1"; shift
until nc -z "$host" "$1"; do
echo "waiting for $host:$1..."; sleep 0.5;
done
shift
exec "$@"