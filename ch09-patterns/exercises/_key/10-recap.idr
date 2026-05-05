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

pdigit : Parser Integer
pdigit = MkParser (\input =>
  case unpack input of
    (c :: xs) =>
      if isDigit c
        then Just (cast (ord c - ord '0'), pack xs)
        else Nothing
    []        => Nothing)

pseq : Parser a -> Parser b -> Parser (a, b)
pseq p q = MkParser (\input =>
  case runParser p input of
    Nothing         => Nothing
    Just (x, rest1) =>
      case runParser q rest1 of
        Nothing         => Nothing
        Just (y, rest2) => Just ((x, y), rest2))

pcount : Nat -> Parser a -> Parser (List a)
pcount Z     _ = MkParser (\s => Just ([], s))
pcount (S k) p = MkParser (\s =>
  case runParser p s of
    Nothing      => Nothing
    Just (x, s1) =>
      case runParser (pcount k p) s1 of
        Nothing       => Nothing
        Just (xs, s2) => Just (x :: xs, s2))

digitsToStr : List Integer -> String
digitsToStr = pack . map (\n => chr (cast n + ord '0'))

threeDashFour : Parser String
threeDashFour = MkParser (\input =>
  case runParser (pseq (pcount 3 pdigit)
                       (pseq (pchar '-')
                             (pcount 4 pdigit))) input of
    Just ((a, (_, b)), rest) =>
        Just (digitsToStr a ++ "-" ++ digitsToStr b, rest)
    _ => Nothing)

main : IO ()
main = printLn (runParser threeDashFour "555-1234end")
