module Main

import Data.SortedMap

%default total

-- New idea: `keys m` and `values m` give you back the keys and values as
-- ordinary lists. Both are exported from `Data.SortedMap` in this Idris.
--
-- TODO: replace `FIXME` with `values m` so the program prints the keys
--       on the first line and the values on the second.

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2), ("c", 3)])
  printLn (keys m)
  printLn (keys m)
