module Server.Content

import Generated.Routes
import Shared.Ids

%default total

------------------------------------------------------------------------
-- Slug -> Route lookup. Markdown bodies are served as static files by
-- the Node bridge (from `web/client/build/serve/assets/<slug>.md`); the
-- server only sees structured metadata.
------------------------------------------------------------------------

export
lookupBySlug : LessonSlug -> Maybe Route
lookupBySlug = fromSlug

export
metaFor : Route -> LessonMeta
metaFor = lessonMeta
