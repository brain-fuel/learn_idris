module Main

import Data.String
import Data.List

%default total

findTotal : List String -> Maybe String
findTotal xs = find (isInfixOf "TOTAL") xs

main : IO ()
main = do
  let sample = ["Coffee Shop", "Latte 3.50", "TOTAL: $42.99"]
  case findTotal sample of
    Just l  => putStrLn ("found: " ++ l)
    Nothing => putStrLn "no total"
