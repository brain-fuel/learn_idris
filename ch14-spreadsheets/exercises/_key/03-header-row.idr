module Main

%default total

-- Exercise 03 KEY: pull the header row off a list of rows.

headerRow : List (List String) -> List String
headerRow []        = []
headerRow (r :: _)  = r

main : IO ()
main = do
  let rs = [["date", "category", "amount"], ["2026-01-15", "food", "42.00"]]
  putStrLn (show (headerRow rs))
