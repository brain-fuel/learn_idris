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

main : IO ()
main = do
  let canvas : Grid = replicate 3 (replicate 4 (the Pixel (0, 0, 0)))
  printLn (drawRect 1 0 2 2 (255, 255, 255) canvas)
