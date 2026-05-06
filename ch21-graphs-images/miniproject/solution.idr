module Main

import Data.String
import Data.List
import Data.List1
import Data.Nat
import System.File

%default total

-- Chapter 21 miniproject — chart-from-tsv.
--
-- Read miniproject/fixtures/values.tsv (4 rows: label<TAB>number),
-- render a 20-wide x 10-tall PPM-P3 bar chart, write it to
-- /tmp/learn_idris_ch21_chart.ppm, and print three lines to stdout:
--
--   wrote /tmp/learn_idris_ch21_chart.ppm
--   20 10
--   P3 sample first row: 255 255 255  255 255 255  ...   <- 20 pixels
--
-- The driver greps for "wrote ...chart.ppm", "P3", "20 10", and "255".
--
-- TODO:
--   1. Read the TSV (parse each "label\tnumber" line into (String, Nat)).
--   2. Pick four x-columns (e.g. [2, 6, 10, 14]) and pair them with the
--      parsed heights to produce `List (Nat, Nat)`.
--   3. Build a 20x10 white canvas, paint each bar (use exercise 09's
--      `bars` shape), serialise with `emit 20 10`, and `writeFile` it.
--   4. Print the three lines above. The stub prints "FIXME"-laden
--      placeholders so the driver fails until you fix this.

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

covering
main : IO ()
main = do
  putStrLn "wrote FIXME"
  putStrLn "0 0"
  putStrLn "P3 FIXME"
