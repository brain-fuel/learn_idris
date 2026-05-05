module Main

import Data.List

%default total

-- New idea: a `List a` might be empty, so asking for the first element
-- could fail. Idris makes you face that head-on: `head'` returns
-- `Maybe a`. You must pattern-match both `Just x` (got one) and
-- `Nothing` (list was empty). This is the safety lesson — there's no
-- silent crash like Python's `IndexError`.
--
-- TODO: add the missing `Nothing` case so the file typechecks. When the
--       list is empty, print `"empty list"`.

main : IO ()
main = case head' (the (List Int) []) of
         Just x  => printLn x
         Nothing => putStrLn "PLACEHOLDER"
