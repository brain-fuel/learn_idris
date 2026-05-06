module Main

import Data.String
import Data.List1

%default total

-- New idea: a CSV row is a `String` with fields separated by commas.
-- Splitting it gives back a `List String`. Use `Data.String.split` with
-- the predicate `(== ',')`. That returns `List1 String` (always
-- non-empty); call `forget` to convert it to `List String`.
--
-- TODO: replace `[]` so `splitRow` returns the comma-separated fields.

splitRow : String -> List String
splitRow s = []

main : IO ()
main = do
  let row = "Ada,ada@example.com,36"
  putStrLn "FIXME: split the row on commas"
  printLn (splitRow row)
