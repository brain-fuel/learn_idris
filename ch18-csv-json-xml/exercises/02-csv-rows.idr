module Main

import Data.String
import Data.List1

%default total

-- New idea: a CSV file is multiple rows. Split on `\n` first to get
-- lines, then split each line on `,`.
--
-- TODO: replace `[]` so `splitRows` returns one `List String` per line.

splitFields : String -> List String
splitFields s = forget (split (== ',') s)

splitRows : String -> List (List String)
splitRows s = []

main : IO ()
main = do
  let text = "Ada,36\nBob,29"
  putStrLn "FIXME: split on newlines, then on commas"
  printLn (splitRows text)
