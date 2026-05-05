module Main

import Data.SortedMap

%default total

-- New idea: `fromList` builds a `SortedMap` from a list of `(key, value)`
-- pairs in one shot. Much shorter than chaining `insert` calls.
--
-- TODO: replace `FIXME` with `fromList` so the map is built from the
--       three pairs below.

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [])
  printLn (Data.SortedMap.toList m)
