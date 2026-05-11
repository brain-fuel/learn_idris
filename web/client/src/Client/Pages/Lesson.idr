module Client.Pages.Lesson

import Client.State
import Client.Components.Layout
import Text.HTML

%default total

export
view : AppModel -> Node AppEvent
view = Layout.view
