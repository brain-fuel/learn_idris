module Shared.Protocol

import JSON.Derive
import Shared.Ids
import Shared.State

%default total
%language ElabReflection

public export
protocolVersion : Nat
protocolVersion = 1

------------------------------------------------------------------------
-- Client -> Server messages (closed sum: adding a constructor forces
-- both sides to recompile).
------------------------------------------------------------------------

public export
data ClientMsg
  = CHello Nat                              -- protocolVersion echo
  | CLoadLesson LessonSlug
  | CCompleteLesson LessonSlug
  | CSandboxOpen
  | CSandboxStdin SessionId String
  | CSandboxClose SessionId
  | CPing Bits64

------------------------------------------------------------------------
-- Server -> Client messages.
------------------------------------------------------------------------

public export
data ServerMsg
  = SHello Nat (Maybe User)
  | SState AppState
  | SSandboxOpened SessionId
  | SSandboxStdout SessionId String
  | SSandboxStderr SessionId String
  | SSandboxExit SessionId Int
  | SError ErrorCode String
  | SPong Bits64

------------------------------------------------------------------------
-- Envelope: every wire message is wrapped to carry version + timestamp.
-- Server picks `Envelope ServerMsg`, client picks `Envelope ClientMsg`.
------------------------------------------------------------------------

public export
record Envelope a where
  constructor MkEnvelope
  v   : Nat
  ts  : Bits64
  msg : a

%runElab derive "ClientMsg" [Show, Eq, ToJSON, FromJSON]
%runElab derive "ServerMsg" [Show, Eq, ToJSON, FromJSON]
%runElab derive "Envelope"  [Show, Eq, ToJSON, FromJSON]
