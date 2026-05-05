module Main

import Data.String

%default total

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pdigit : Parser Integer
pdigit = MkParser (\input =>
  case unpack input of
    (c :: xs) =>
      if isDigit c
        then Just (cast (ord c - ord '0'), pack xs)
        else Nothing
    []        => Nothing)

main : IO ()
main = printLn (runParser pdigit "42x")
