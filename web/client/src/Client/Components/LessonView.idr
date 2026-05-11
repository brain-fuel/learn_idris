module Client.Components.LessonView

import Client.State
import Generated.Routes
import Shared.Ids
import Text.HTML
import Text.CSS.Class

%default total

-- Center pane. Shows one of:
--   - "Loading..." when lessonBody is Nothing and no error
--   - The sanitized HTML (set via dangerouslyInnerHtml) when rendered is set
--   - An error banner when fetchError is set
-- The actual innerHTML mutation happens in App.display via raw target ref,
-- not in the Node view. The Node view is just a placeholder div the Cmd
-- writes into.

export
mountId : String
mountId = "lesson-pane"

export
view : AppModel -> Node AppEvent
view m =
  section [class "lesson-pane", Id (Id mountId)]
    [ case (m.fetchError, m.rendered, m.lessonBody) of
        (Just err, _, _)  => div [class "fetch-error"] [Text ("Failed to load: " ++ err)]
        (_, Just _, _)    => Text ""    -- HTML written into this node by Cmd
        _                 => div [class "loading"] [Text "Loading lesson..."]
    ]
