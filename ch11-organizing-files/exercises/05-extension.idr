module Main

import Data.String
import Data.List

%default total

-- New idea: Idris's base has no `os.path.splitext` analogue, so we
-- carve the extension out by hand. Strategy: reverse the characters,
-- `break` on the first `.`, and the prefix (re-reversed) is the
-- extension. Lowercase it so `.JPG` and `.jpg` agree.
--
-- TODO: complete `extension` so that
--           extension "Photo.JPG" == ".jpg"
--           extension "no_ext"    == ""
--       Hint: `break (== '.') xs` returns `(before, atOrAfter)`. The
--       second component still includes the matched `'.'`.

extension : String -> String
extension _ = ""

main : IO ()
main = printLn (extension "P.JPG")
