module Client.WSClient

import Client.FFI.WS
import JS
import JSON
import Shared.Protocol

%default total

------------------------------------------------------------------------
-- Open a WebSocket, return the handle. `onMsg` receives raw JSON; the
-- consumer decodes via `decodeServer` below. `onClose` fires once when
-- the connection drops (cleanly or otherwise).
------------------------------------------------------------------------

export
connect :  HasIO io
        => (url      : String)
        -> (onMsg    : String -> IO ())
        -> (onClose  : Int -> String -> IO ())
        -> io WSHandle
connect = wsOpen

------------------------------------------------------------------------
-- Encode a ClientMsg (wrapped in Envelope v1) and send it.
------------------------------------------------------------------------

export
sendClient : HasIO io => WSHandle -> ClientMsg -> io ()
sendClient h msg = do
  let env : Envelope ClientMsg
      env = MkEnvelope protocolVersion 0 msg
  wsSend h (encode env)

------------------------------------------------------------------------
-- Decode an incoming wire payload into a ServerMsg, ignoring the
-- envelope wrapper. Returns Left with the parser error on failure.
------------------------------------------------------------------------

export
decodeServer : String -> Either String ServerMsg
decodeServer raw =
  case decodeEither {a = Envelope ServerMsg} raw of
    Left err  => Left err
    Right env => Right env.msg

export
close : HasIO io => WSHandle -> io ()
close = wsClose
