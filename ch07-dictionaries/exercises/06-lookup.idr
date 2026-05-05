module Main

import Data.SortedMap

%default total

-- New idea: `lookup` returns `Maybe v`, NOT `v`. There is no "key error"
-- exception in Idris -- the compiler forces you to write code for the
-- missing case via `Nothing`.
--
-- TODO: add the missing `Nothing => ...` arm so the `case` covers both
--       constructors of `Maybe`. With `%default total`, an incomplete
--       `case` is a coverage error and the file will not check.

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2)])
  case lookup "a" m of
    Just v => printLn v
    Nothing => putStrLn "PLACEHOLDER"
    -- TODO: add a `Nothing => putStrLn "missing"` arm here.
