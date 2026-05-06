module Main

import Data.List

%default total

-- Exercise 05 KEY: pair a header row with a data row.

zipHeader : List String -> List String -> List (String, String)
zipHeader header row = zip header row

main : IO ()
main = do
  let h = ["date", "category", "amount"]
  let r = ["2026-01-15", "food", "42.00"]
  putStrLn (show (zipHeader h r))
