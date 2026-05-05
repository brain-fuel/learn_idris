module Main

import Data.String

%default total

-- New idea: `words` splits a `String` on whitespace and gives back a
-- `List String`. It is forgiving: empty input gives `[]`.
--
-- TODO: replace `FIXME` with `words` so the program prints
--       `["the", "quick", "brown", "fox"]`.

main : IO ()
main = printLn ((\_ => the (List String) []) "the quick brown fox")
