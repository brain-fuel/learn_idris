module Main

import Data.String
import Data.List1

%default total

-- New idea: `sqlite3 -separator $'\t' ...` returns rows where columns
-- are tab-delimited. To turn one row into a list of column values,
-- split on `\t`.
--
-- Note: `Data.String.split` returns `Data.List1.List1 a` (non-empty
-- list). Convert to a regular `List` with `forget`.
--
-- TODO: split `row` on `'\t'` and return the resulting `List String`.

splitRow : String -> List String
splitRow row = []

main : IO ()
main = printLn (splitRow "1\tlaundry\t0")
