module Main

import System.Directory
import Data.String
import Data.List

%default total

-- New idea: a one-level walk. We don't recurse into subdirectories
-- because Idris's base has no `isDirectory` to ask "is this entry a
-- directory?" — and that's the chapter's whole point. We classify by
-- filename suffix instead.
--
-- TODO: for each entry in `dir01`, print `<entry> -> <classify entry>`
--       on its own line. Sort the entries first so output is
--       deterministic.

extension : String -> String
extension s =
  let cs = unpack s in
  case break (== '.') (reverse cs) of
    (revExt, '.' :: _) => toLower (pack ('.' :: reverse revExt))
    _ => ""

classify : String -> String
classify f =
  let e = extension f in
  if e == ".jpg" || e == ".jpeg" || e == ".png" || e == ".heic" then "images"
  else if e == ".mov" || e == ".mp4" then "video"
  else if e == ".txt" || e == ".md" then "notes"
  else "other"

main : IO ()
main = putStrLn "(skipped)"
