module Main

import Data.List
import Data.Nat

%default total

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

main : IO ()
main = do
  let canvas : Grid = replicate 4 (replicate 4 (the Pixel (255, 255, 255)))
  printLn (bar 4 1 3 canvas)
