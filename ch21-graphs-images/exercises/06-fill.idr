module Main

import Data.List
import Data.String

%default total

-- New idea: the simplest grid you can build is a uniform canvas —
-- every pixel is the same colour. Use `Data.List.replicate` to make a
-- row of `w` copies of one pixel, then replicate that row `h` times
-- to get the grid.
--
-- TODO: implement `fill` so it returns a `h`-tall, `w`-wide grid of
--       the given colour. The stub returns the empty grid `[]`.
-- HINT: `replicate : Nat -> a -> List a` (lives in `Data.List`).

fill : Nat -> Nat -> (Int, Int, Int) -> List (List (Int, Int, Int))
fill _ _ _ = []

main : IO ()
main = printLn (fill 3 2 (255, 255, 255))
