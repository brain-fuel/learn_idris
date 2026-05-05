module Main

import Data.String

%default total

-- New idea: `pany` is the "match anything as long as there is something"
-- parser. It always consumes one character and returns it (along with
-- the rest of the string), or fails on an empty input.
--
--     runParser pany "abc"  ==  Just ('a', "bc")
--     runParser pany ""     ==  Nothing
--
-- This is the building block for combinators that don't care WHICH
-- character comes next, only that one is there.
--
-- TODO: replace the body of `pany` with a parser that pattern-matches
--       on `unpack input`:
--         (x :: xs) => Just (x, pack xs)
--         []        => Nothing

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pany : Parser Char
pany = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser pany "abc")
