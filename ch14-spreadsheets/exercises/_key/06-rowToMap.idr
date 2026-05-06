module Main

import Data.List
import Data.SortedMap

%default total

-- Exercise 06 KEY: turn a row + header into a SortedMap String String.

rowToMap : List String -> List String -> SortedMap String String
rowToMap header row =
  foldl (\m, (k, v) => insert k v m) empty (zip header row)

main : IO ()
main = do
  let h = ["date", "category", "amount"]
  let r = ["2026-01-15", "food", "42.00"]
  let m = rowToMap h r
  putStrLn (show (lookup "category" m))
