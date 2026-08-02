#!/usr/bin/env bash

set -euo pipefail

INTERVAL="${HEARTBEAT_INTERVAL:-}"

if [[ -z "$INTERVAL" ]]; then
    echo "ERROR: HEARTBEAT_INTERVAL is not configured" >&2
    exit 1
fi

if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]]; then
    echo "ERROR: HEARTBEAT_INTERVAL must be an integer, got: $INTERVAL" >&2
    exit 1
fi

if (( INTERVAL < 1 || INTERVAL > 60 )); then
    echo "ERROR: HEARTBEAT_INTERVAL must be between 1 and 60" >&2
    exit 1
fi

echo "Config checker started with interval: ${INTERVAL}s"

while true; do
    echo "Configuration check successful: $(date --iso-8601=seconds)"
    sleep "$INTERVAL"
done
