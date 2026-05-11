module Server.Router

import Generated.Routes
import Server.Content
import Server.Storage
import Server.Session
import Shared.Ids
import Shared.Protocol
import Shared.State

%default total

------------------------------------------------------------------------
-- Pure dispatch over ClientMsg. v1 covers only the non-sandbox messages
-- (CHello / CLoadLesson / CCompleteLesson / CPing); the bridge owns
-- CSandbox* and never forwards them to us.
------------------------------------------------------------------------

emptyAppState : AppState
emptyAppState = MkAppState Nothing emptyProgress Loading
  where
    emptyProgress : Progress
    emptyProgress = MkProgress (MkUserId "anon") [] Nothing

export covering
dispatch : HasIO io => ClientMsg -> io ServerMsg
dispatch (CHello v) =
  pure (SHello protocolVersion Nothing)

dispatch (CLoadLesson slug) =
  case Content.lookupBySlug slug of
    Nothing   => pure (SError ProtocolMismatch ("unknown slug: " ++ unLessonSlug slug))
    Just _    => pure (SState emptyAppState)
      -- TODO: full progress sync once Storage.FsBackend is wired into the
      -- session record. v1 ships read-only state.

dispatch (CCompleteLesson _) =
  -- TODO: persist via Storage. v1 acks with the same empty state.
  pure (SState emptyAppState)

dispatch CSandboxOpen =
  pure (SError ProtocolMismatch "sandbox routed via bridge, not server")

dispatch (CSandboxStdin _ _) =
  pure (SError ProtocolMismatch "sandbox routed via bridge, not server")

dispatch (CSandboxClose _) =
  pure (SError ProtocolMismatch "sandbox routed via bridge, not server")

dispatch (CPing ts) =
  pure (SPong ts)
