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

partial
many : Parser a -> Parser (List a)
many p = MkParser go where
  partial
  go : String -> Maybe (List a, String)
  go s = case runParser p s of
           Nothing      => Just ([], s)
           Just (x, s1) =>
             case go s1 of
               Just (xs, s2) => Just (x :: xs, s2)
               Nothing       => Just ([x], s1)

partial
main : IO ()
main = printLn (runParser (many pdigit) "123abc")
