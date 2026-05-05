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

main : IO ()
main = printLn (runParser pany "abc")
