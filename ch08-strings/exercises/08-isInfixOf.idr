module Main

import Data.String

%default total

-- New idea: `isInfixOf : String -> String -> Bool` checks whether the
-- first argument (the NEEDLE) appears anywhere inside the second (the
-- HAYSTACK). Needle first, haystack second.
--
-- TODO: replace `FIXME` with `isInfixOf` so the program prints `True`.

main : IO ()
main = printLn (the (String -> String -> Bool) (\_, _ => False) "world" "hello world")
