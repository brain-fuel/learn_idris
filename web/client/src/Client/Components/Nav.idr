module Client.Components.Nav

import Client.Router
import Client.State
import Generated.Routes
import Shared.Ids
import Text.HTML
import Text.CSS.Class

%default total

-- Top nav: brand on the left, list of all routes as anchor links.
-- Anchors use #<slug> which the dom-mvc app picks up via window.onhashchange
-- (wired in Main).

linkFor : Route -> Node AppEvent
linkFor r =
  let m = lessonMeta r
   in a [href (toHash r), onClick (NavTo r)] [Text m.title]

export
view : Route -> Node AppEvent
view current =
  header [class "site-nav"]
    [ div [class "brand"]    [Text "Learn Idris"]
    , nav [class "chapters"] (map linkFor allRoutes)
    ]
