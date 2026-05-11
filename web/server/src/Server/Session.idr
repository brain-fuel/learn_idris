module Server.Session

import Shared.Ids

%default total

------------------------------------------------------------------------
-- v1: cookie-signed sessions live in the Node bridge (Node has stdlib
-- crypto). The Idris server only sees `SessionId` strings on the wire.
-- This module is a thin re-export so handlers can take/return SessionId
-- without importing Shared.Ids everywhere.
------------------------------------------------------------------------

public export
SessionId : Type
SessionId = Shared.Ids.SessionId
