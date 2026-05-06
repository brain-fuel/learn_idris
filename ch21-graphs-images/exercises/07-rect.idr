module Main

import Data.List
import Data.String

%default total

-- New idea: a filled rectangle paints all pixels inside the box
-- `[x0..x0+w-1]` x `[y0..y0+h-1]` to the given colour, leaving the
-- rest of the grid untouched. We index rows and columns by `Nat`.
--
-- TODO: implement `drawRect` so it walks each row with its index
--       (call it `y`) and, when `y` is in `[y0..y0+h-1]`, walks each
--       cell with its index (`x`) and paints `(x, y)` if it falls in
--       `[x0..x0+w-1]`. The stub leaves the grid unchanged.
-- HINT: define a helper `paintRow : (rowIndex : Nat) -> Row -> Row`
--       that uses `zip` with `[0..]` (or a custom index walk) to
--       decide per-pixel whether to overwrite.

Pixel : Type
Pixel = (Int, Int, Int)

Grid : Type
Grid = List (List Pixel)

drawRect : Nat -> Nat -> Nat -> Nat -> Pixel -> Grid -> Grid
drawRect _ _ _ _ _ g = g

main : IO ()
main = do
  let canvas = replicate 3 (replicate 4 (the Pixel (0, 0, 0)))
  printLn (drawRect 1 0 2 2 (255, 255, 255) canvas)
