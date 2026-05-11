module Client.Router

import Generated.Routes
import Shared.Ids

%default total

-- Pure routing. URL hash <-> Route. Hash format: "#<slug>" (e.g. "#stub").
-- Empty / unknown hash -> Nothing (caller decides home vs 404).

export
parseHash : String -> Maybe Route
parseHash s =
  let slug = stripHash s
   in fromSlug (MkLessonSlug slug)
  where
    stripHash : String -> String
    stripHash str = case unpack str of
      ('#' :: rest) => pack rest
      _             => str

export
toHash : Route -> String
toHash r = "#" ++ unLessonSlug (toSlug r)
