module Client.FFI.WS

%default total

-- TODO Task 3: bind WebSocket constructor + onmessage callback.
-- %foreign "browser:lambda: (u, cb) => { const s = new WebSocket(u); ... }"
-- prim__wsOpen : String -> (String -> PrimIO ()) -> PrimIO AnyPtr
