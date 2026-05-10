module Server.FFI.Chez

%default total

-- Opaque host-side handles. Their layouts live in Chez Scheme; Idris only
-- ever holds Ptrs to them and passes them back through these primitives.
-- The associated Scheme procedures are defined in web/scheme-host/host.ss.
public export data Request  : Type where
public export data Response : Type where
public export data WsConn   : Type where
public export data WsFrame  : Type where
public export data WsAction : Type where
public export data Buf      : Type where
  -- ^ stand-in for Data.Buffer.Buffer; replaced once contrib is wired

------------------------------------------------------------------------
-- HTTP host: register handlers, then call listen.
------------------------------------------------------------------------

%foreign "scheme:web-host-register-route"
prim__registerRoute : String
                   -> (Ptr Request -> PrimIO (Ptr Response))
                   -> PrimIO ()

%foreign "scheme:web-host-register-ws"
prim__registerWs : String
                -> (Ptr WsFrame -> PrimIO (Ptr WsAction))
                -> PrimIO ()

%foreign "scheme:web-host-listen"
prim__listen : Int -> PrimIO ()

------------------------------------------------------------------------
-- Request accessors
------------------------------------------------------------------------

%foreign "scheme:web-host-req-method"
prim__reqMethod : Ptr Request -> PrimIO String

%foreign "scheme:web-host-req-path"
prim__reqPath : Ptr Request -> PrimIO String

%foreign "scheme:web-host-req-header"
prim__reqHeader : Ptr Request -> String -> PrimIO String

%foreign "scheme:web-host-req-body"
prim__reqBody : Ptr Request -> PrimIO (Ptr Buf)

------------------------------------------------------------------------
-- Response constructor
------------------------------------------------------------------------

%foreign "scheme:web-host-resp-make"
prim__respMake : Int -> String -> Ptr Buf -> PrimIO (Ptr Response)

------------------------------------------------------------------------
-- WebSocket I/O
------------------------------------------------------------------------

%foreign "scheme:web-host-ws-send"
prim__wsSend : Ptr WsConn -> Ptr Buf -> PrimIO ()

%foreign "scheme:web-host-ws-close"
prim__wsClose : Ptr WsConn -> Int -> PrimIO ()

------------------------------------------------------------------------
-- Misc utility primitives provided by the host
------------------------------------------------------------------------

%foreign "scheme:web-host-now-millis"
prim__nowMillis : PrimIO Bits64

%foreign "scheme:web-host-rand-bytes"
prim__randBytes : Int -> PrimIO (Ptr Buf)
