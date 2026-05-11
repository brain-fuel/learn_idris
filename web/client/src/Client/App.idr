module Client.App

import Client.Components.Layout
import Client.Components.LessonView
import Client.FFI.Fetch
import Client.FFI.WS
import Client.Markdown
import Client.Router
import Client.State
import Client.WSClient
import Generated.Routes
import JS
import JSON
import Shared.Ids
import Shared.Protocol
import Text.HTML
import Text.CSS.Class
import Web.MVC

%default total

------------------------------------------------------------------------
-- DOM refs
------------------------------------------------------------------------

appRoot : Ref Tag.Div
appRoot = Id "app"

lessonPane : Ref Tag.Section
lessonPane = Id LessonView.mountId

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------

assetUrl : Route -> String
assetUrl r = "assets/" ++ unLessonSlug (toSlug r) ++ ".md"

------------------------------------------------------------------------
-- update : pure transition over AppModel
------------------------------------------------------------------------

export
update : AppEvent -> AppModel -> AppModel
update NoOp m = m

update (NavTo r) m =
  { route      := r
  , lessonBody := Nothing
  , rendered   := Nothing
  , fetchError := Nothing
  } m

update (LessonFetched _ raw) m =
  { lessonBody := Just raw } m

update (LessonRendered _ html) m =
  { rendered := Just html } m

update (LessonFetchFailed _ err) m =
  { fetchError := Just err } m

update (ReplInputChanged s) m =
  { repl->input := s } m

update ReplOpenClicked m =
  { repl->status := Connecting } m

update ReplSubmitClicked m =
  { repl->status := Connecting } m

update ReplResetClicked m =
  { repl := emptyRepl } m

update (ReplWsRecv raw) m =
  case decodeServer raw of
    Left _    => m
    Right msg => { repl $= applyServerMsg msg } m

update (ReplWsClosed _ reason) m =
  { repl->status := Disconnected Nothing
                      (if reason == "" then "connection closed" else reason)
  , repl->ws     := Nothing
  } m

------------------------------------------------------------------------
-- display : produce the Cmd that updates the DOM after `update` ran.
-- Strategy: render the full shell into #app on every event (cheap dom-mvc
-- diffs internally). Then for lesson rendering, push raw HTML into the
-- lesson pane via the `raw` Cmd helper. Async work (fetch, WS open) is
-- expressed as a custom Cmd that fires more events later.
------------------------------------------------------------------------

renderShell : AppModel -> Cmd AppEvent
renderShell m = child appRoot (Layout.view m)

renderLessonHtml : Maybe String -> Cmd AppEvent
renderLessonHtml Nothing     = noAction
renderLessonHtml (Just html) = raw lessonPane html

fetchLessonCmd : Route -> Cmd AppEvent
fetchLessonCmd r =
  C $ \h => fetchText (assetUrl r)
    (\body => runJS $ h (LessonFetched (toSlug r) body))
    (\_, msg => runJS $ h (LessonFetchFailed (toSlug r) msg))

renderMarkdownCmd : LessonSlug -> String -> Cmd AppEvent
renderMarkdownCmd slug raw =
  C $ \h => do
    html <- render raw
    h (LessonRendered slug html)

openWsCmd : Cmd AppEvent
openWsCmd =
  C $ \h => do
    _ <- connect "ws://localhost:8080/ws"
            (\msg          => runJS $ h (ReplWsRecv msg))
            (\code, reason => runJS $ h (ReplWsClosed code reason))
    pure ()

export
display : AppEvent -> AppModel -> Cmd AppEvent

display NoOp m = renderShell m

display (NavTo r) m =
  renderShell m <+> fetchLessonCmd r

display (LessonFetched slug raw) m =
  renderShell m <+> renderMarkdownCmd slug raw

display (LessonRendered _ html) m =
  renderShell m <+> renderLessonHtml (Just html)

display (LessonFetchFailed _ _) m =
  renderShell m

display (ReplInputChanged _) _ = noAction
  -- textarea is uncontrolled; no DOM write needed

display ReplOpenClicked m =
  renderShell m <+> openWsCmd

display ReplSubmitClicked m =
  renderShell m <+> openWsCmd
  -- v1: clicking Run also opens WS. Real backend integration in Task 4+.

display ReplResetClicked m = renderShell m

display (ReplWsRecv _)        m = renderShell m
display (ReplWsClosed _ _)    m = renderShell m
