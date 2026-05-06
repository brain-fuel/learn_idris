module Main

import Data.String
import Data.SortedMap

%default total

-- Exercise 10: pretty-print a per-category totals map as report lines.
--
-- For input like {"food" => 150.5, "transport" => 87.25} we want:
--     food          150.50
--     transport     87.25
-- followed by a TOTAL line. Numbers always show two decimals.
--
-- TODO: replace the body with a join of one line per (category, amount)
-- pair, using the provided `fmt2` helper for the numbers. Add a
-- "TOTAL <fmt2 sumOfAmounts>" line at the end.
-- Hint:
--   let pairs = Data.SortedMap.toList totals
--       lines = map (\(c, a) => c ++ "\t" ++ fmt2 a) pairs
--       grand = foldl (+) 0.0 (map snd pairs)
--   in unlines (lines ++ ["TOTAL\t" ++ fmt2 grand])

fmt2 : Double -> String
fmt2 x =
  let cents : Integer
      cents = cast (x * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

renderReport : SortedMap String Double -> String
renderReport totals = "FIXME"

main : IO ()
main = do
  let m = insert "food" 150.5 (insert "transport" 87.25 empty)
  putStrLn (renderReport m)
