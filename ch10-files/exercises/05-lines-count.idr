module Main

import System.File
import Data.String

%default total

-- Combine `lines` with `words` to count total words across a file.
--
-- TODO: replace `printLn 0` so the program reads
--       `ch10-files/exercises/fixtures/three-lines.txt`, splits into
--       lines, counts the words on each line with `words`, sums them,
--       and prints the total. The fixture has three single-word lines,
--       so the expected output is `3`.
--       Hint: `let n = sum (map (length . words) ls)` then `printLn n`.
--       (Name it `n` -- `total` clashes with the `total` keyword.)

main : IO ()
main = printLn (the Nat 0)
