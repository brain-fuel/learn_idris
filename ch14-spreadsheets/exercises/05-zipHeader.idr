module Main

import Data.List

%default total

-- Exercise 05: pair a header row with a data row.
--
-- Given header ["date","category","amount"] and row ["2026-01-15","food","42.00"]
-- we want [("date","2026-01-15"), ("category","food"), ("amount","42.00")].
--
-- TODO: replace the body with `zip header row` (Prelude `zip` works).

zipHeader : List String -> List String -> List (String, String)
zipHeader header row = []

main : IO ()
main = do
  let h = ["date", "category", "amount"]
  let r = ["2026-01-15", "food", "42.00"]
  putStrLn (show (zipHeader h r))
