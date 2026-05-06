module Main

import Data.List
import Data.SortedMap

%default total

-- Exercise 06: turn a row + header into a SortedMap String String.
--
-- Same idea as zipHeader, but the result is a map keyed by column name.
-- Looking up "amount" returns the cell value.
--
-- TODO: replace the body so it folds the zipped pairs into a SortedMap.
-- Hint: `foldl (\m, (k, v) => insert k v m) empty (zip header row)`.

rowToMap : List String -> List String -> SortedMap String String
rowToMap header row = empty

main : IO ()
main = do
  let h = ["date", "category", "amount"]
  let r = ["2026-01-15", "food", "42.00"]
  let m = rowToMap h r
  putStrLn (show (lookup "category" m))
