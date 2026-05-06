module Main

import Data.List
import Data.List1
import Data.String
import Data.SortedMap
import System.File

%default total

-- Miniproject KEY: read miniproject/fixtures/expenses.tsv (committed),
-- compute per-category totals + a grand total, print a tab-formatted
-- report.

tsvPath : String
tsvPath = "ch14-spreadsheets/miniproject/fixtures/expenses.tsv"

splitOnTab : String -> List String
splitOnTab s = forget (split (== '\t') s)

isEmptyRow : List String -> Bool
isEmptyRow []     = True
isEmptyRow [""]   = True
isEmptyRow _      = False

rowsFromText : String -> List (List String)
rowsFromText s =
  filter (\r => not (isEmptyRow r))
         (map splitOnTab (forget (split (== '\n') s)))

parseAmount : String -> Double
parseAmount s = cast s

-- Each row in this fixture is `date<TAB>category<TAB>amount` (no header).
catAndAmount : List String -> Maybe (String, Double)
catAndAmount [_, cat, amt] = Just (cat, parseAmount amt)
catAndAmount _             = Nothing

bump : SortedMap String Double -> (String, Double) -> SortedMap String Double
bump m (cat, amt) =
  case lookup cat m of
    Just old => insert cat (old + amt) m
    Nothing  => insert cat amt m

groupByCategory : List (String, Double) -> SortedMap String Double
groupByCategory pairs = foldl bump empty pairs

fmt2 : Double -> String
fmt2 x =
  let cents : Integer
      cents = cast (x * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

renderReport : SortedMap String Double -> String
renderReport totals =
  let pairs = Data.SortedMap.toList totals
      lines = map (\(c, a) => c ++ "\t" ++ fmt2 a) pairs
      grand = foldl (+) 0.0 (map snd pairs)
  in unlines (lines ++ ["TOTAL\t" ++ fmt2 grand])

covering
main : IO ()
main = do
  -- Consume the trigger line so the cat-pipe doesn't block.
  _ <- getLine
  Right text <- readFile tsvPath
    | Left e => putStrLn ("error: " ++ show e)
  let rows  = rowsFromText text
  let pairs = mapMaybe catAndAmount rows
  let totals = groupByCategory pairs
  putStr (renderReport totals)
