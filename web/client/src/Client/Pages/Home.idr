module Client.Pages.Home

import Client.State
import Client.Components.Layout
import Text.HTML

%default total

-- Home view = same shell. Lesson pane shows a welcome until a route is
-- picked from the nav. Kept intentionally thin — the routing decision
-- lives in App.display.

export
view : AppModel -> Node AppEvent
view = Layout.view
