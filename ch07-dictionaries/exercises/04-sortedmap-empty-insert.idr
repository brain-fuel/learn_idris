module Main

import Data.SortedMap

%default total

-- New idea: Idris's dictionary is `SortedMap k v` from `Data.SortedMap`.
-- Build one from `empty` and grow it with `insert key value m`. Like
-- everything in Idris, `insert` returns a NEW map -- the old one is
-- untouched.
--
-- TODO: replace `FIXME` with `insert "y" 2 m1` so that `m2` has both
--       entries. Note `Data.SortedMap.toList` is qualified to avoid
--       clashing with `Prelude.toList`.

main : IO ()
main = do
  let m1 = the (SortedMap String Int) (insert "x" 1 empty)
  let m2 = m1
  printLn (Data.SortedMap.toList m2)
