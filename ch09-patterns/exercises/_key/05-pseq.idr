module Main

import Data.String

%default total

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pchar : Char -> Parser Char
pchar c = MkParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

pseq : Parser a -> Parser b -> Parser (a, b)
pseq p q = MkParser (\input =>
  case runParser p input of
    Nothing         => Nothing
    Just (x, rest1) =>
      case runParser q rest1 of
        Nothing         => Nothing
        Just (y, rest2) => Just ((x, y), rest2))

main : IO ()
main = printLn (runParser (pseq (pchar 'h') (pchar 'i')) "hi!")
