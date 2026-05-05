module Main

import Data.String

%default total

-- New idea: a PARSER is a function that consumes a prefix of a string.
-- It returns either `Just (value, leftover)` -- meaning "I parsed a
-- value and here is the rest of the string" -- or `Nothing` if it
-- couldn't match.
--
--     Parser a  ==  String -> Maybe (a, String)
--
-- We wrap that arrow in a one-field record so the type shows up in
-- error messages with a proper name.
--
-- TODO: replace the body of `pchar` so that, given a target Char `c`,
--       it returns a parser that:
--         * succeeds with `Just (c, rest)` if the input starts with `c`
--         * fails (returns `Nothing`) otherwise
--       Use `unpack` to peek at the head of the input:
--         case unpack input of
--           (x :: xs) => if x == c then Just (c, pack xs) else Nothing
--           []        => Nothing

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pchar : Char -> Parser Char
pchar c = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser (pchar 'a') "apple")
