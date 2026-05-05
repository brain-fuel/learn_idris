module Main

import Data.String

%default total

-- New idea: `runParser` is the field accessor on the `Parser` record.
-- Given a parser and an input string, it gives you back a `Maybe`.
-- That's the "drive the parser end-to-end" step.
--
--     runParser (pchar 'h') "hello"  ==  Just ('h', "ello")
--
-- TODO: replace the FIXME line with
--           printLn (runParser (pchar 'h') "hello")
--       so the program prints `Just ('h', "ello")`.

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pchar : Char -> Parser Char
pchar c = MkParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

main : IO ()
main = printLn (the (Maybe (Char, String)) Nothing)
