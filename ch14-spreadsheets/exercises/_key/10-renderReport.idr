module Main

import Data.String
import Data.SortedMap

%default total

-- Exercise 10 KEY: pretty-print a per-category totals map as report lines.

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

main : IO ()
main = do
  let m = insert "food" 150.5 (insert "transport" 87.25 empty)
  putStrLn (renderReport m)
