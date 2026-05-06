module Main

import Data.SortedMap

%default total

-- Exercise 09 KEY: group (category, amount) pairs into per-category totals.

bump : SortedMap String Double -> (String, Double) -> SortedMap String Double
bump m (cat, amt) =
  case lookup cat m of
    Just old => insert cat (old + amt) m
    Nothing  => insert cat amt m

groupByCategory : List (String, Double) -> SortedMap String Double
groupByCategory pairs = foldl bump empty pairs

main : IO ()
main = do
  let pairs = [("food", 42.0), ("transport", 12.25), ("food", 60.0)]
  let m = groupByCategory pairs
  putStrLn (show (lookup "food" m))
