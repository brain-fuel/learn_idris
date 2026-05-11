module Server.Uds

import JSON
import Server.FFI.Chez
import Shared.Ids
import Shared.Protocol

%default total

------------------------------------------------------------------------
-- Typed framing: read/write Shared.Protocol.Envelope payloads over the
-- raw byte stream that FFI.Chez exposes.
------------------------------------------------------------------------

public export
data UdsError
  = PeerClosed                  -- read returned ""
  | DecodeFailed String         -- json decoded to error
  | EncodeFailed                -- encode produced an unexpected error

export
Show UdsError where
  show PeerClosed       = "peer closed"
  show (DecodeFailed s) = "decode: " ++ s
  show EncodeFailed     = "encode failed"

------------------------------------------------------------------------

export covering
readClientFrame : HasIO io => Int -> io (Either UdsError (Envelope ClientMsg))
readClientFrame fd = do
  raw <- udsReadFrame fd
  if raw == ""
    then pure (Left PeerClosed)
    else case decodeEither {a = Envelope ClientMsg} raw of
           Left err  => pure (Left (DecodeFailed err))
           Right env => pure (Right env)

export covering
writeServerFrame : HasIO io => Int -> Envelope ServerMsg -> io ()
writeServerFrame fd env = udsWriteFrame fd (encode env)

------------------------------------------------------------------------
-- Connection lifecycle. Per accepted connection: keep reading frames
-- and dispatching them through the supplied handler until the peer
-- closes the socket or a decode error fires. Errors are surfaced as
-- SError envelopes back to the bridge (which surfaces to the client).
------------------------------------------------------------------------

errorEnvelope : String -> Envelope ServerMsg
errorEnvelope msg = MkEnvelope protocolVersion 0 (SError InternalError msg)

export covering
handleConn :  HasIO io
           => Int
           -> (Envelope ClientMsg -> io (Envelope ServerMsg))
           -> io ()
handleConn fd handler = do
  result <- readClientFrame fd
  case result of
    Left PeerClosed       => udsClose fd
    Left (DecodeFailed e) => do
      writeServerFrame fd (errorEnvelope ("decode: " ++ e))
      udsClose fd
    Left EncodeFailed     => udsClose fd
    Right env             => do
      reply <- handler env
      writeServerFrame fd reply
      handleConn fd handler

------------------------------------------------------------------------
-- Top-level accept loop. v1: synchronous, one connection at a time.
-- Concurrency lives in the Node bridge (event loop); the server is
-- deterministic + reentrancy-free.
------------------------------------------------------------------------

export covering
acceptLoop :  HasIO io
           => (path : String)
           -> (Envelope ClientMsg -> io (Envelope ServerMsg))
           -> io ()
acceptLoop path handler = do
  server <- udsListen path
  loop server
  where
    covering
    loop : Int -> io ()
    loop server = do
      conn <- udsAccept server
      handleConn conn handler
      loop server
