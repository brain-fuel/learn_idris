module Client.Components.Layout

import Client.State
import Text.HTML
import Text.CSS.Class

import public Client.Components.Nav
import public Client.Components.LessonView
import public Client.Components.Repl

%default total

-- Shell: nav at top, two-column main (lesson | repl), footer.
-- Mobile collapse driven by CSS (style.css), not by JS.

export
view : AppModel -> Node AppEvent
view m =
  div [class "shell"]
    [ Nav.view m.route
    , main_ [class "two-col"]
        [ LessonView.view m
        , Repl.view m.repl
        ]
    , footer [class "site-footer"]
        [ Text "Learn Idris · EPL-2.0 · "
        , a [href "https://github.com/brain-fuel/learn_idris"] [Text "source"]
        ]
    ]
