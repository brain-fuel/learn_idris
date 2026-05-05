module Main

import Data.Vect

%default total

-- Recap: `Vect n a` carries its length in the type, `sum` adds all
-- elements, and `cast : Nat -> Int` lets you divide a sum by a length.
--
-- TODO: replace each `FIXME` with an integer score (any five integers).
--       Then run with `idris2 --exec main 10-recap.idr` to see the
--       average. Example: `[80, 75, 92, 60, 88]` averages to `79`.

scores : Vect 5 Int
scores = [0, 0, 0, 0, 0]

average : Vect (S n) Int -> Int
average xs = sum xs `div` cast (length xs)

main : IO ()
main = printLn (average scores)
