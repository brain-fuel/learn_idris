module Main

import Data.String
import Data.List
import Data.List1
import Data.Nat
import System.File

%default total

-- Chapter 21 miniproject KEY — chart-from-tsv.
--
-- Reads a 4-row TSV at miniproject/fixtures/values.tsv, builds a
-- 20-wide x 10-tall PPM-P3 bar chart, writes it to /tmp, and prints
-- the success line, the dimensions, and the rendered first row.

Pixel : Type
Pixel = (Int, Int, Int)

Row : Type
Row = List Pixel

Grid : Type
Grid = List Row

tsvPath : String
tsvPath = "ch21-graphs-images/miniproject/fixtures/values.tsv"

outPath : String
outPath = "/tmp/learn_idris_ch21_chart.ppm"

chartW : Nat
chartW = 20

chartH : Nat
chartH = 10

-- pixel grid helpers (mirroring exercises 01..09)

showPixel : Pixel -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : Row -> String
showRow row = joinBy "  " (map showPixel row)

showGrid : Grid -> String
showGrid rows = joinBy "\n" (map showRow rows)

header : Nat -> Nat -> String
header w h = "P3\n" ++ show w ++ " " ++ show h ++ "\n255\n"

emit : Nat -> Nat -> Grid -> String
emit w h rows = header w h ++ showGrid rows ++ "\n"

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
bar h col height g = drawRect col (minus h height) 1 height (0, 0, 0) g

bars : List (Nat, Nat) -> Grid
bars pairs =
  let canvas : Grid = replicate chartH (replicate chartW (255, 255, 255))
  in foldl (\g, (col, h) => bar chartH col h g) canvas pairs

-- TSV parsing

parseLine : String -> Maybe (String, Nat)
parseLine line =
  case forget (split (== '\t') line) of
    [name, val] => Just (name, cast val)
    _           => Nothing

parseRows : List String -> List (String, Nat)
parseRows = mapMaybe parseLine

-- Layout: 4 bars at columns 2, 6, 10, 14 (4-wide stride, 2-pixel pad).

layout : List (String, Nat) -> List (Nat, Nat)
layout rows =
  let cols : List Nat = [2, 6, 10, 14]
      hs   : List Nat = map snd rows
  in zip cols hs

firstRowText : Grid -> String
firstRowText []          = ""
firstRowText (row :: _)  = showRow row

covering
main : IO ()
main = do
  Right contents <- readFile tsvPath
    | Left err => putStrLn ("error: could not read TSV: " ++ show err)
  let rawLines = filter (\l => l /= "") (lines contents)
  let rows     = parseRows rawLines
  let grid     = bars (layout rows)
  let body     = emit chartW chartH grid
  _ <- writeFile outPath body
  putStrLn ("wrote " ++ outPath)
  putStrLn (show chartW ++ " " ++ show chartH)
  putStrLn ("P3 sample first row: " ++ firstRowText grid)
