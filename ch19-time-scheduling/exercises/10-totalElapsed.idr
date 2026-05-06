module Main

import Data.List

%default total

-- Exercise 10: sum elapsed minutes.
--
-- `sum : Foldable t => t a -> a` works for any `List a` where `a` is
-- numeric. `[25, 5, 30, 45]` should sum to `105`.
--
-- TODO: implement `totalElapsed` so it sums the list and `main`
-- prints `total: 105`.

totalElapsed : List Int -> Int
totalElapsed _ = 0

main : IO ()
main = do
  let xs : List Int
      xs = [25, 5, 30, 45]
  putStrLn ("total: " ++ show (totalElapsed xs))
