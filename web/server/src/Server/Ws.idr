module Server.Ws

%default total

-- TODO: per-conn frame loop; decode Shared.Protocol.ClientMsg, produce
-- Shared.Protocol.ServerMsg, send via Server.FFI.Chez.prim__wsSend.
