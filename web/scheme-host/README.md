# scheme-host

Thin Chez Scheme harness around the Idris-emitted Scheme image. Owns sockets,
HTTP/1.1 framing, and RFC 6455 WebSocket framing. Idris owns all logic and
calls into this layer through the `%foreign "scheme:web-host-..."` primitives
declared in `web/server/src/Server/FFI/Chez.idr`.

## Boot order

1. Compile the server: `idris2 --codegen chez --build web-server.ipkg` produces
   `build/exec/web-server` plus an `.ss` image.
2. Chez script `host.ss` loads the image, then calls the Idris-exported init
   thunk (registered through `prim__registerRoute` / `prim__registerWs`).
3. `prim__listen <port>` enters the accept loop. Per accepted connection,
   `(fork-thread ...)` spawns a worker that:
   - reads request bytes (`http.ss` parses HTTP/1.1 head + body);
   - on `Upgrade: websocket`, runs the handshake, hands the socket to the
     registered WS callback (`ws.ss` provides per-frame decode/encode);
   - otherwise dispatches the request to the route callback registered for
     the path prefix.
4. Idris callbacks return `(status headers body-bytes)` (HTTP) or
   `(send <bytes>)` / `(close <code>)` action records (WS) which `host.ss`
   serializes back to the wire.

## FFI contract (mirror of Server.FFI.Chez)

| Scheme procedure                  | Idris primitive          |
|-----------------------------------|--------------------------|
| `web-host-register-route`         | `prim__registerRoute`    |
| `web-host-register-ws`            | `prim__registerWs`       |
| `web-host-listen`                 | `prim__listen`           |
| `web-host-req-method`             | `prim__reqMethod`        |
| `web-host-req-path`               | `prim__reqPath`          |
| `web-host-req-header`             | `prim__reqHeader`        |
| `web-host-req-body`               | `prim__reqBody`          |
| `web-host-resp-make`              | `prim__respMake`         |
| `web-host-ws-send`                | `prim__wsSend`           |
| `web-host-ws-close`               | `prim__wsClose`          |
| `web-host-now-millis`             | `prim__nowMillis`        |
| `web-host-rand-bytes`             | `prim__randBytes`        |

All `Ptr T` values on the Idris side are opaque host structures on the Scheme
side — pass them back as-is to other primitives; never cross the boundary
unwrapped.

## Status

Stub. `host.ss`, `http.ss`, `ws.ss` carry only top-level placeholders. Real
implementations land in Task 2+ once the Idris side has a working
`Server.Main` to drive them.

## Validation flags

- REQUIRES VALIDATION: the chez bundled with `idris2 0.8.0` exposes
  `make-server-socket`, `accept`, and binary ports usable for HTTP/1.1
  framing. Confirm with a one-record spike before depending on this design.
- Fallback path: terminate TLS at nginx and have Chez listen on a Unix
  domain socket — drops public-internet exposure of hand-rolled framing.
