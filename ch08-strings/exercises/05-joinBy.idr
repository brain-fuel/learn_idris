module Main

import Data.String

%default total

-- New idea: `joinBy : String -> List String -> String` glues a list of
-- strings together with a separator between them. The argument order is
-- SEPARATOR FIRST, list second.
--
-- TODO: replace `FIXME` with `joinBy` so the program prints `a-b-c`.

main : IO ()
main = putStrLn (the (String -> List String -> String) (\_, _ => "") "-" ["a", "b", "c"])
