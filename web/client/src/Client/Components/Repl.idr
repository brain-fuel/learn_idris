module Client.Components.Repl

import Client.State
import Shared.Ids
import Text.HTML
import Text.CSS.Class

%default total

------------------------------------------------------------------------
-- DOM ids the App uses with Cmd helpers (e.g. text/raw on a Ref).
------------------------------------------------------------------------

export
inputRefId : String
inputRefId = "repl-input"

export
outputRefId : String
outputRefId = "repl-output"

------------------------------------------------------------------------
-- Status badge text.
------------------------------------------------------------------------

statusText : ReplStatus -> String
statusText Ready                    = "ready"
statusText Connecting               = "connecting..."
statusText (Streaming _)            = "running"
statusText (Done _ code)            = "exit " ++ show code
statusText (Disconnected _ msg)     = "disconnected: " ++ msg

statusClass : ReplStatus -> Class
statusClass Ready              = "status ready"
statusClass Connecting         = "status connecting"
statusClass (Streaming _)      = "status streaming"
statusClass (Done _ 0)         = "status done-ok"
statusClass (Done _ _)         = "status done-fail"
statusClass (Disconnected _ _) = "status disconnected"

isRunning : ReplStatus -> Bool
isRunning (Streaming _) = True
isRunning Connecting    = True
isRunning _             = False

------------------------------------------------------------------------
-- Render the widget. The textarea is uncontrolled (we don't reset its
-- value on every render); we only consume its content on Submit via
-- onInput accumulating into ReplInputChanged.
------------------------------------------------------------------------

export
view : ReplWidget -> Node AppEvent
view r =
  aside [class "repl"]
    [ div [class "repl-header"]
        [ span [class "title"] [Text "REPL"]
        , span [class (statusClass r.status)] [Text (statusText r.status)]
        ]
    , textarea [ Id (Id inputRefId)
               , class "repl-input"
               , placeholder "type Idris here, then click Run"
               , onInput ReplInputChanged
               ] []
    , div [class "repl-buttons"]
        [ button [onClick ReplSubmitClicked]
            [Text (if isRunning r.status then "..." else "Run")]
        , button [onClick ReplResetClicked] [Text "Reset"]
        ]
    , pre [Id (Id outputRefId), class "repl-output"]
        [Text (concat r.output)]
    ]
