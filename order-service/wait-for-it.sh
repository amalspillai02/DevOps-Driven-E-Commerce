#!/usr/bin/env bash
#   Use this script to test if a given TCP host/port are available

host="$1"
port="$2"
shift 2

until nc -z "$host" "$port"; do
  echo "Waiting for $host:$port..."
  sleep 1
done

exec "$@"
