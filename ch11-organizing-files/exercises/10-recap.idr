module Main

import System.Directory
import Data.String
import Data.List

%default total

-- Recap: tie it all together — `listDir` + `sort` + `classify` + a
-- printed plan.
--
-- TODO: for each entry in `ch11-organizing-files/exercises/fixtures/recap-dir/`,
--       print `moved <name> -> <category>/<name>`. Sort the entries
--       first. On `Left` of `listDir`, print `error`.

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
main = for_ (the (List String) []) putStrLn
