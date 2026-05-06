module Main

import Data.List

%default total

elapsedFromJournal : List Int -> List Int
elapsedFromJournal xs =
  map (\(a, b) => b - a) (zip xs (drop 1 xs))

main : IO ()
main = do
  let xs : List Int
      xs = [540, 565, 570, 600, 645]
  printLn (elapsedFromJournal xs)
