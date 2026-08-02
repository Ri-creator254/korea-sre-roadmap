#!/usr/bin/env bash

set -euo pipefail

echo "Monitoring worker started"

while true; do
    echo "Monitoring heartbeat: $(date --iso-8601=seconds)"
    sleep 5
done
