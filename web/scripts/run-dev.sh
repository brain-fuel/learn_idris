#!/usr/bin/env bash
# Boots the full dev stack: sandbox worker -> Idris-on-Chez server -> Node bridge.
# Writes PIDs to web/var/run/. Tails nothing; logs land in web/var/run/*.log.
# Use ./scripts/stop-dev.sh to tear down.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
webroot="$(cd "$here/.." && pwd)"
rundir="$webroot/var/run"
logdir="$webroot/var/log"
mkdir -p "$rundir" "$logdir"

UDS_PATH="${UDS_PATH:-$rundir/server.sock}"
SANDBOX_PORT="${SANDBOX_PORT:-7401}"
BRIDGE_PORT="${BRIDGE_PORT:-8080}"
JAIL="${JAIL:-none}"
export UDS_PATH SANDBOX_PORT BRIDGE_PORT JAIL

# Stale socket from a previous crashed run will block bind().
rm -f "$UDS_PATH"

start() {
  local name="$1"; shift
  local logfile="$logdir/$name.log"
  local pidfile="$rundir/$name.pid"
  ( "$@" >"$logfile" 2>&1 ) &
  echo $! > "$pidfile"
  echo "  $name pid=$(cat "$pidfile") log=$logfile"
}

echo "==> dev stack starting"
echo "  UDS_PATH=$UDS_PATH"
echo "  SANDBOX_PORT=$SANDBOX_PORT JAIL=$JAIL"
echo "  BRIDGE_PORT=$BRIDGE_PORT"
echo

# 1. Sandbox worker
( cd "$webroot/sandbox" && start sandbox \
    env PORT="$SANDBOX_PORT" JAIL="$JAIL" \
    node src/worker.mjs )

# 2. Idris-on-Chez server
( cd "$webroot" && start server \
    env UDS_PATH="$UDS_PATH" \
    "$webroot/server/build/exec/web-server" )

# Give the server a moment to create the socket so the bridge's first send
# doesn't race a missing path.
for _ in 1 2 3 4 5 6 7 8 9 10; do
  [ -S "$UDS_PATH" ] && break
  sleep 0.2
done

# 3. Bridge (HTTP/WS facing the browser)
( cd "$webroot/bridge" && start bridge \
    env PORT="$BRIDGE_PORT" \
        UDS_PATH="$UDS_PATH" \
        SANDBOX_URL="ws://127.0.0.1:$SANDBOX_PORT/control" \
        STATIC_ROOT="$webroot/client/build/serve" \
    node src/server.mjs )

echo
echo "==> all up. Open http://localhost:$BRIDGE_PORT/"
echo "    ./scripts/stop-dev.sh to tear down"
