module Main

import Data.List

%default total

-- New idea: `sort` from `Data.List` returns a new list with the
-- elements in ascending order. Idris does NOT mutate the input — the
-- old list is still the same; you get a fresh, sorted one back.
--
-- TODO: replace `FIXME` with `sort` so the program prints the list in
--       ascending order.

main : IO ()
main = printLn (id (the (List Int) [3, 1, 4, 1, 5, 9, 2, 6]))
