#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT="$SCRIPT_DIR/process_report.txt"

echo "Starting test process..."

sleep 120 &
PID=$!

{
    echo "Linux process management lab"
    echo "Date: $(date --iso-8601=seconds)"
    echo
    echo "Process after start:"
    ps -p "$PID" -o pid,ppid,user,stat,%cpu,%mem,etime,cmd
} > "$REPORT"

kill -STOP "$PID"
sleep 1

{
    echo
    echo "Process after STOP signal:"
    ps -p "$PID" -o pid,ppid,user,stat,%cpu,%mem,etime,cmd
} >> "$REPORT"

kill -CONT "$PID"
sleep 1

{
    echo
    echo "Process after CONT signal:"
    ps -p "$PID" -o pid,ppid,user,stat,%cpu,%mem,etime,cmd
} >> "$REPORT"

kill -TERM "$PID"
wait "$PID" 2>/dev/null || true

{
    echo
    echo "Process $PID was terminated successfully."
} >> "$REPORT"

echo "Report created: $REPORT"
