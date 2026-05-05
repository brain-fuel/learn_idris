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

palt : Parser a -> Parser a -> Parser a
palt p q = MkParser (\input =>
  case runParser p input of
    Just r  => Just r
    Nothing => runParser q input)

main : IO ()
main = printLn (runParser (palt (pchar 'h') (pchar 'b')) "bye")
