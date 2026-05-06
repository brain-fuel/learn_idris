module Main

%default total

-- Exercise 03: pull the header row off a list of rows.
--
-- A real spreadsheet usually has a header row (column names) followed
-- by data rows. We want to peel off the first row.
--
-- TODO: replace the body so it returns the FIRST row, or `[]` for an
-- empty list.

headerRow : List (List String) -> List String
headerRow rs = ["FIXME"]

main : IO ()
main = do
  let rs = [["date", "category", "amount"], ["2026-01-15", "food", "42.00"]]
  putStrLn (show (headerRow rs))
