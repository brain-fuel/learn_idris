module Client.FFI.WS

import JS

%default total

-- Opaque handle to the underlying browser WebSocket. The Idris side never
-- inspects it; passes it back to send/close.
public export
data WSHandle : Type where [external]

%foreign "browser:lambda: (u,onMsg,onClose,w) => { const s = new WebSocket(u); s.onmessage = e => onMsg(String(e.data))(w); s.onclose = e => onClose((e.code|0))(String(e.reason || ''))(w); s.onerror = () => {}; return s; }"
prim__wsOpen :  String
             -> (String -> IO ())             -- onMessage(payload)
             -> (Int -> String -> IO ())      -- onClose(code, reason)
             -> PrimIO WSHandle

%foreign "browser:lambda: (s,m,w) => { try { s.send(m); } catch (e) {} }"
prim__wsSend : WSHandle -> String -> PrimIO ()

%foreign "browser:lambda: (s,w) => { try { s.close(); } catch (e) {} }"
prim__wsClose : WSHandle -> PrimIO ()

export
wsOpen :  HasIO io
       => String
       -> (String -> IO ())
       -> (Int -> String -> IO ())
       -> io WSHandle
wsOpen u onMsg onClose = primIO (prim__wsOpen u onMsg onClose)

export
wsSend : HasIO io => WSHandle -> String -> io ()
wsSend s m = primIO (prim__wsSend s m)

export
wsClose : HasIO io => WSHandle -> io ()
wsClose s = primIO (prim__wsClose s)
