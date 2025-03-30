#!/usr/bin/env bash
set -x
set -eo pipefail

# Determine which container runtime to use (docker or podman)
if command -v podman &> /dev/null; then
    CONTAINER_RUNTIME="podman"
elif command -v docker &> /dev/null; then
    CONTAINER_RUNTIME="docker"
else
    echo >&2 "Error: neither podman nor docker is installed."
    exit 1
fi

# if a redis container is running, print instructions to kill it and exit
RUNNING_CONTAINER=$(${CONTAINER_RUNTIME} ps --filter 'name=redis' --format '{{.ID}}')
if [[ -n $RUNNING_CONTAINER ]]; then
  echo >&2 "there is a redis container already running, kill it with"
  echo >&2 "    ${CONTAINER_RUNTIME} kill ${RUNNING_CONTAINER}"
  exit 1
fi

# Launch Redis using container runtime
${CONTAINER_RUNTIME} run \
    -p "6379:6379" \
    -d \
    --name "redis_$(date '+%s')" \
    redis:7

>&2 echo "Redis is ready to go!"
