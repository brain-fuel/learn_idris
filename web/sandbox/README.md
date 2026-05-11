# sandbox — REPL executor worker

A Node WS server that wraps a long-lived `idris2 --no-banner` child per
session under a pluggable jail backend. The Idris-on-Chez server (still
unbuilt) will speak this protocol over a single loopback control WS,
multiplexing every user's sandbox session through it.

## Run

```sh
make -C .. web-sandbox-deps     # one-time: npm install ws zod pino
make -C .. web-sandbox-run      # boots on ws://127.0.0.1:7401/control
```

## Manual smoke (no server needed)

```sh
npm i -g wscat                  # or `npx wscat -c ...`
wscat -c ws://127.0.0.1:7401/control
> {"kind":"Open","sid":"x"}
< {"kind":"Opened","sid":"x"}
< {"kind":"Stdout","sid":"x","chunk":"Main> "}
> {"kind":"Stdin","sid":"x","data":":t Nat"}
< {"kind":"Stdout","sid":"x","chunk":"Prelude.Nat : Type\nMain> "}
> {"kind":"Close","sid":"x"}
< {"kind":"Exited","sid":"x","code":-1}
```

## Tests

```sh
make -C .. web-sandbox-test
```

Two specs:

- `test/protocol.spec.mjs` — zod schema round-trips for every W2S + S2W
  constructor; rejects malformed/missing/unknown frames.
- `test/smoke.spec.mjs` — spawns the worker on a random port (`PORT=0`,
  `JAIL=none`), drives a full Open → Stdin → Close lifecycle, asserts
  `:t Nat` → stdout chunk containing `Nat`, and that bad frames + unknown
  sids produce `Denied`.

## Jail backends

`JAIL` env var selects the adapter at startup:

| Backend  | Available locally? | Notes                                    |
|----------|--------------------|------------------------------------------|
| `bwrap`  | yes                | **Default.** Bubblewrap; locally available. |
| `firejail` | no               | Uses `profiles/idris2.firejail.profile`. |
| `nsjail` | no                 | Same constraint matrix expressed in nsjail flags. |
| `none`   | always             | Passthrough — **NO isolation. Debug only.** |

Each adapter is a ~30-line module under `src/jail/<name>.mjs` exporting
`available()` and `command(argv)`. To add a new backend, drop a sibling
file and register it in `src/jail/index.mjs`.

### bwrap details

- Read-only binds `/usr`, `/etc`, the pack-installed package tree, and
  `~/.idris2`. Symlinks `/bin`/`/sbin`/`/lib`/`/lib64` to their `/usr/*`
  counterparts (so `#!/bin/sh` resolves on modern Debian/Ubuntu).
- Unshares net / IPC / PID / UTS.
- Wraps the inner argv with `/usr/bin/prlimit --as=256M --cpu=30
  --nproc=16` for resource caps.
- Resolves the real `idris2` binary path via `pack app-path idris2` at
  startup (the on-PATH `idris2` is a pack shim that may not be reachable
  from inside the sandbox).

## Config

All env-driven. See `src/config.mjs` for defaults:

| Env var               | Default     | Meaning                              |
|-----------------------|-------------|--------------------------------------|
| `HOST`                | `127.0.0.1` | WS bind host                         |
| `PORT`                | `7401`      | WS bind port; `0` = random           |
| `WS_PATH`             | `/control`  | WS path                              |
| `JAIL`                | `bwrap`     | Jail backend selector                |
| `MAX_LIVE_SANDBOXES`  | `32`        | Concurrent session cap               |
| `IDLE_MS`             | `120000`    | Idle timeout per session             |
| `WALL_MS`             | `600000`    | Hard wall-clock cap per session      |
| `LOG_LEVEL`           | `info`      | pino level                           |

Per-session in addition: token bucket of 20 tokens, refilling 1/sec.
Each non-empty `Stdin` consumes 1 token. Empty `Stdin` is a no-op.

## Wire protocol

Tagged-union JSON over WS text frames. Validated both directions by zod
(`src/protocol.mjs`).

Worker receives (W2S):
- `{ kind: "Open",  sid }`
- `{ kind: "Stdin", sid, data }`
- `{ kind: "Close", sid }`

Worker sends (S2W):
- `{ kind: "Opened", sid }`
- `{ kind: "Stdout", sid, chunk }`
- `{ kind: "Stderr", sid, chunk }`
- `{ kind: "Exited", sid, code }`
- `{ kind: "Denied", sid, reason }`

`Server.SandboxClient` on the Idris side will mirror this exact shape
once it lands.

## Security caveats

- Loopback-only by design. Never expose `:7401` publicly; the protocol
  has no auth.
- `JAIL=none` exists for debugging. Treat it as DOOM-equivalent: every
  child shares the worker's full process namespace + network.
- `prlimit --as` caps virtual memory, not RSS — aggressive workloads can
  still page-thrash. Production hosts should add cgroup-based RAM caps
  (e.g. `systemd-run --user --scope -p MemoryMax=256M`).
- WS backpressure is not yet implemented; long stdout floods can balloon
  worker memory if the server reads slowly.
