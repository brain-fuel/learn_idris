module Main

import Data.List
import Data.List1
import Data.String
import Data.SortedMap
import System.File

%default total

-- Miniproject STUB: print a category-totals report by reading
--   ch14-spreadsheets/miniproject/fixtures/expenses.tsv
--
-- The fixture has 6 rows (no header) of: date<TAB>category<TAB>amount.
-- The expected output groups by category and prints a TOTAL line:
--
--     food            150.50
--     transport       87.25
--     entertainment   30.00
--     TOTAL           267.75
--
-- This stub prints FIXMEs so the test driver fails until you fill in
-- the helpers below. Reuse what you wrote in exercises 01..10.
--
-- TODO: replace the FIXME bodies of `rowsFromText`, `catAndAmount`,
-- `groupByCategory`, and `renderReport` with their real definitions.

tsvPath : String
tsvPath = "ch14-spreadsheets/miniproject/fixtures/expenses.tsv"

splitOnTab : String -> List String
splitOnTab s = forget (split (== '\t') s)

rowsFromText : String -> List (List String)
rowsFromText s = []

parseAmount : String -> Double
parseAmount s = cast s

-- Each row is `date<TAB>category<TAB>amount` (no header). The placeholder
-- always returns Nothing — fix it to extract (category, amount).
catAndAmount : List String -> Maybe (String, Double)
catAndAmount _ = Nothing

groupByCategory : List (String, Double) -> SortedMap String Double
groupByCategory pairs = empty

renderReport : SortedMap String Double -> String
renderReport totals =
  "food\tFIXME\ntransport\tFIXME\nentertainment\tFIXME\nTOTAL\tFIXME\n"

covering
main : IO ()
main = do
  _ <- getLine
  Right text <- readFile tsvPath
    | Left e => putStrLn ("error: " ++ show e)
  let rows   = rowsFromText text
  let pairs  = mapMaybe catAndAmount rows
  let totals = groupByCategory pairs
  putStr (renderReport totals)
