module Main

import Data.String
import Data.List1

%default total

-- Exercise 01: split a single TSV line into a list of fields.
--
-- A TSV (tab-separated values) row uses '\t' between columns. This
-- exercise just splits one line. Note that `Data.String.split` returns
-- a `List1` (a non-empty list), so we convert with `forget` to get a
-- plain `List`.
--
-- TODO: replace the FIXME body with `forget (split (== '\t') s)` so
-- that "a\tb\tc" produces ["a","b","c"].

splitOnTab : String -> List String
splitOnTab s = ["FIXME"]

main : IO ()
main = do
  let row = splitOnTab "date\tcategory\tamount"
  putStrLn (show row)
