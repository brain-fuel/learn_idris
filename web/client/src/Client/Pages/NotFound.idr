module Client.Pages.NotFound

import Client.State
import Client.Components.Nav
import Text.HTML
import Text.CSS.Class

%default total

export
view : AppModel -> Node AppEvent
view m =
  div [class "shell"]
    [ Nav.view m.route
    , main_ [class "not-found"]
        [ h1 [] [Text "404"]
        , Text "Route not found."
        ]
    ]
