module Main

import Data.String

%default total

-- New idea: `toUpper` and `toLower` (in `Data.String`) take a whole
-- `String` and return a new one with every character uppercased /
-- lowercased. Unlike many languages, you do NOT call them per-character.
--
-- TODO: replace `FIXME` with `toUpper` so the program prints `HELLO`.

main : IO ()
main = putStrLn (id "hello")
