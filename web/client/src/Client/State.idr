module Client.State

import Client.FFI.WS
import Generated.Routes
import Shared.Ids
import Shared.Protocol

%default total

------------------------------------------------------------------------
-- REPL widget state
------------------------------------------------------------------------

public export
data ReplStatus
  = Ready                          -- never run; or reset
  | Connecting                     -- WS opening, no SHello yet
  | Streaming SessionId            -- got SSandboxOpened (or SHello + open msg)
  | Done SessionId Int             -- got SSandboxExit
  | Disconnected (Maybe SessionId) String
                                   -- WS closed or SError

public export
record ReplWidget where
  constructor MkRepl
  input  : String                  -- current textarea content
  output : List String             -- accumulated stdout/stderr chunks
  status : ReplStatus
  ws     : Maybe WSHandle          -- live WS handle, if any

public export
emptyRepl : ReplWidget
emptyRepl = MkRepl "" [] Ready Nothing

------------------------------------------------------------------------
-- App-wide model
------------------------------------------------------------------------

public export
record AppModel where
  constructor MkModel
  route       : Route              -- current page
  lessonBody  : Maybe String       -- raw markdown (pre-render)
  rendered    : Maybe String       -- sanitized HTML
  fetchError  : Maybe String       -- last fetch failure for current route
  repl        : ReplWidget

public export
initModel : AppModel
initModel = MkModel
  { route      = Ch00Hello
  , lessonBody = Nothing
  , rendered   = Nothing
  , fetchError = Nothing
  , repl       = emptyRepl
  }

------------------------------------------------------------------------
-- Events handled by `update`. Includes both user-initiated DOM events
-- and async callbacks fired from FFI (fetch, WS).
------------------------------------------------------------------------

public export
data AppEvent
  = NoOp
    --
    -- Routing / navigation
  | NavTo Route
    --
    -- Lesson content fetch
  | LessonFetched LessonSlug String       -- raw markdown
  | LessonRendered LessonSlug String      -- sanitized HTML
  | LessonFetchFailed LessonSlug String
    --
    -- REPL textarea + buttons
  | ReplInputChanged String
  | ReplOpenClicked
  | ReplSubmitClicked
  | ReplResetClicked
    --
    -- WS callbacks
  | ReplWsRecv String                     -- raw JSON envelope
  | ReplWsClosed Int String

------------------------------------------------------------------------
-- Pure transitions on ReplStatus given a decoded ServerMsg.
-- Returns updated repl + chunks the view should render.
------------------------------------------------------------------------

export
applyServerMsg : ServerMsg -> ReplWidget -> ReplWidget
applyServerMsg (SSandboxOpened sid) r =
  { status := Streaming sid } r
applyServerMsg (SSandboxStdout _ chunk) r =
  { output $= (++ [chunk]) } r
applyServerMsg (SSandboxStderr _ chunk) r =
  { output $= (++ ["[stderr] " ++ chunk]) } r
applyServerMsg (SSandboxExit sid code) r =
  { status := Done sid code } r
applyServerMsg (SError _ msg) r =
  let sid = case r.status of
              Streaming s   => Just s
              Done s _      => Just s
              Disconnected ms _ => ms
              _             => Nothing
   in { status := Disconnected sid msg } r
applyServerMsg _ r = r
