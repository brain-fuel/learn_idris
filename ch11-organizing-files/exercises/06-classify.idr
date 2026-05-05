module Main

import Data.String
import Data.List

%default total

-- New idea: build a classifier on top of `extension`. Same strategy as
-- before — break on the last dot, lowercase — then map the suffix to a
-- category name.
--
-- TODO: complete `classify` so that
--         .jpg / .jpeg / .png / .heic   -> "images"
--         .mov / .mp4                   -> "video"
--         .txt / .md                    -> "notes"
--         anything else                 -> "other"

extension : String -> String
extension s =
  let cs = unpack s in
  case break (== '.') (reverse cs) of
    (revExt, '.' :: _) => toLower (pack ('.' :: reverse revExt))
    _ => ""

classify : String -> String
classify _ = "other"

main : IO ()
main = printLn (classify "a.jpg")
