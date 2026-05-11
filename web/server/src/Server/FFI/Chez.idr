module Server.FFI.Chez

%default total

-- Unix-domain-socket primitives. Implementations live in
-- web/scheme-host/uds.ss; the chez codegen splices them in via
-- `--directive extraRuntime=...` set in web-server.ipkg.

%foreign "scheme:uds-listen"
prim__udsListen : String -> PrimIO Int

%foreign "scheme:uds-accept"
prim__udsAccept : Int -> PrimIO Int

%foreign "scheme:uds-read-frame"
prim__udsReadFrame : Int -> PrimIO String

%foreign "scheme:uds-write-frame"
prim__udsWriteFrame : Int -> String -> PrimIO ()

%foreign "scheme:uds-close"
prim__udsClose : Int -> PrimIO ()

------------------------------------------------------------------------
-- Idris-side wrappers.
------------------------------------------------------------------------

export
udsListen : HasIO io => String -> io Int
udsListen path = primIO (prim__udsListen path)

export
udsAccept : HasIO io => Int -> io Int
udsAccept fd = primIO (prim__udsAccept fd)

||| Returns "" on clean EOF (peer closed the connection).
export
udsReadFrame : HasIO io => Int -> io String
udsReadFrame fd = primIO (prim__udsReadFrame fd)

export
udsWriteFrame : HasIO io => Int -> String -> io ()
udsWriteFrame fd payload = primIO (prim__udsWriteFrame fd payload)

export
udsClose : HasIO io => Int -> io ()
udsClose fd = primIO (prim__udsClose fd)
