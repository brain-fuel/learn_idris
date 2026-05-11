#!/usr/bin/env bash
# Tear down the dev stack started by run-dev.sh.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
webroot="$(cd "$here/.." && pwd)"
rundir="$webroot/var/run"

for name in bridge server sandbox; do
  pidfile="$rundir/$name.pid"
  [ -f "$pidfile" ] || continue
  pid="$(cat "$pidfile")"
  if kill -0 "$pid" 2>/dev/null; then
    echo "  $name pid=$pid -> SIGTERM"
    kill -TERM "$pid" 2>/dev/null || true
    for _ in 1 2 3 4 5; do
      kill -0 "$pid" 2>/dev/null || break
      sleep 0.2
    done
    kill -0 "$pid" 2>/dev/null && kill -KILL "$pid" 2>/dev/null || true
  else
    echo "  $name pid=$pid not running"
  fi
  rm -f "$pidfile"
done

# Clean up the UDS path so a re-run's bind() doesn't trip on a stale inode.
rm -f "$rundir/server.sock"

echo "==> dev stack stopped"
