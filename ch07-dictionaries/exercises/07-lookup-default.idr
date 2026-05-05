module Main

import Data.SortedMap
import Data.Maybe

%default total

-- New idea: when you just want a default for the missing case,
-- `fromMaybe def mx` is shorter than a `case`. It returns `def` for
-- `Nothing` and the inner value for `Just`.
--
-- TODO: replace `FIXME` with `fromMaybe 0 (lookup "z" m)` so the program
--       prints `0` for the missing key.

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2)])
  printLn (the Int 0)
