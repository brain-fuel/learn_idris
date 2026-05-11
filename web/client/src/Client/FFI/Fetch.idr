module Client.FFI.Fetch

import JS

%default total

-- Callback-style HTTP GET that returns text. Avoids Promise interop on the
-- Idris side; success/error fire as IO () callbacks the consumer wires into
-- a Cmd via dom-mvc's `C $ \h => ...` pattern.
%foreign "browser:lambda: (u,ok,err,w) => { fetch(u).then(r => r.ok ? r.text().then(t => ok(t)(w)) : err((r.status|0))(r.statusText)(w)).catch(e => err(0)(String(e))(w)); }"
prim__fetchText :  String
                -> (String -> IO ())            -- onOk(body)
                -> (Int -> String -> IO ())     -- onErr(status, msg)
                -> PrimIO ()

export
fetchText :  HasIO io
          => String
          -> (String -> IO ())
          -> (Int -> String -> IO ())
          -> io ()
fetchText u ok err = primIO (prim__fetchText u ok err)
