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

pcount : Nat -> Parser a -> Parser (List a)
pcount Z     _ = MkParser (\s => Just ([], s))
pcount (S k) p = MkParser (\s =>
  case runParser p s of
    Nothing      => Nothing
    Just (x, s1) =>
      case runParser (pcount k p) s1 of
        Nothing       => Nothing
        Just (xs, s2) => Just (x :: xs, s2))

main : IO ()
main = printLn (runParser (pcount 3 pdigit) "789hello")
