module Main

import Data.String

%default total

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pany : Parser Char
pany = MkParser (\input =>
  case unpack input of
    (x :: xs) => Just (x, pack xs)
    []        => Nothing)

pmap : (a -> b) -> Parser a -> Parser b
pmap f p = MkParser (\input =>
  case runParser p input of
    Just (x, rest) => Just (f x, rest)
    Nothing        => Nothing)

main : IO ()
main = printLn (runParser (pmap toUpper pany) "abc")
