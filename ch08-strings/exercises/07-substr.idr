module Main

import Data.String

%default total

-- New idea: `substr : Nat -> Nat -> String -> String` takes a START
-- index, then a LENGTH, then the string. Out-of-range arguments clip
-- silently rather than erroring.
--
-- TODO: replace the two `FIXME`s with the right `Nat`s so the program
--       prints `world` from `"hello world"`. (Hint: `"hello "` is six
--       characters long.)

main : IO ()
main = putStrLn (substr 0 0 "hello world")
