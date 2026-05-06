module Main

import Data.SortedMap

%default total

-- Exercise 09: group (category, amount) pairs into per-category totals.
--
-- We want a SortedMap String Double where the key is the category and
-- the value is the running sum. When we see a category we already
-- have, ADD to its existing total.
--
-- TODO: replace the body with a fold that does merge-on-insert.
-- Hint:
--   foldl bump empty pairs
-- where
--   bump m (cat, amt) = case lookup cat m of
--                         Just old => insert cat (old + amt) m
--                         Nothing  => insert cat amt m

groupByCategory : List (String, Double) -> SortedMap String Double
groupByCategory pairs = empty

main : IO ()
main = do
  let pairs = [("food", 42.0), ("transport", 12.25), ("food", 60.0)]
  let m = groupByCategory pairs
  putStrLn (show (lookup "food" m))
