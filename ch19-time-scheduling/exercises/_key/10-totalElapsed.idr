module Main

import Data.List

%default total

totalElapsed : List Int -> Int
totalElapsed = sum

main : IO ()
main = do
  let xs : List Int
      xs = [25, 5, 30, 45]
  putStrLn ("total: " ++ show (totalElapsed xs))
