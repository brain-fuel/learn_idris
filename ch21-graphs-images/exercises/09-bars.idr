module Main

import Data.List
import Data.Nat

%default total

-- New idea: a bar chart is several bars side-by-side on a single
-- white canvas. Pick a canvas size (we use 20 wide x 10 tall) and
-- apply `bar` once per `(column, height)` pair.
--
-- TODO: implement `bars` so it starts from a 20x10 white canvas and
--       folds each `(col, height)` over `bar 10 col height`. The stub
--       returns the empty grid `[]`.
-- HINT: `foldl : (b -> a -> b) -> b -> List a -> b`.

Pixel : Type
Pixel = (Int, Int, Int)

Row : Type
Row = List Pixel

Grid : Type
Grid = List Row

withIndex : List a -> List (Nat, a)
withIndex xs = go 0 xs
  where
    go : Nat -> List a -> List (Nat, a)
    go _ []        = []
    go i (x :: ys) = (i, x) :: go (S i) ys

inRange : Nat -> Nat -> Nat -> Bool
inRange lo size i = (lo <= i) && (i < lo + size)

paintRow : Nat -> Nat -> Nat -> Nat -> Pixel -> Nat -> Row -> Row
paintRow x0 y0 w h c y row =
  if inRange y0 h y
    then map (\(x, p) => if inRange x0 w x then c else p) (withIndex row)
    else row

drawRect : Nat -> Nat -> Nat -> Nat -> Pixel -> Grid -> Grid
drawRect x0 y0 w h c grid =
  map (\(y, r) => paintRow x0 y0 w h c y r) (withIndex grid)

bar : Nat -> Nat -> Nat -> Grid -> Grid
bar chartH col height g =
  let y0 = minus chartH height
  in drawRect col y0 1 height (0, 0, 0) g

bars : List (Nat, Nat) -> Grid
bars _ = []

main : IO ()
main = printLn (bars [(2, 3), (5, 6), (8, 2)])
