module Main

import Data.String
import Data.List
import Data.List1

%default total

extractAmount : String -> Maybe Double
extractAmount line =
  let segs = forget (split (== '$') line) in
  case last' segs of
    Nothing  => Nothing
    Just raw => parseDouble (trim raw)

main : IO ()
main = do
  case extractAmount "TOTAL: $42.99" of
    Just d  => putStrLn ("amount: " ++ show d)
    Nothing => putStrLn "no amount"
