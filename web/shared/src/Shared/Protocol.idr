module Shared.Protocol

import Shared.Ids
import Shared.State

%default total

public export
protocolVersion : Nat
protocolVersion = 1

-- TODO Task 2: closed sums for ClientMsg / ServerMsg, Envelope record,
-- %runElab derive [Show, Eq, ToJSON, FromJSON] on every type below.
public export
data ClientMsg : Type where
  CHelloStub : Nat -> ClientMsg

public export
data ServerMsg : Type where
  SHelloStub : Nat -> ServerMsg
