module Main

import Data.String

%default total

-- Recap: this exercise pulls everything together. We're going to
-- assemble Python's `\d{3}-\d{4}` pattern out of the combinators
-- we've already built, and have it return the matched 8-character
-- substring as a `String`.
--
--     runParser threeDashFour "555-1234end"
--                              ==> Just ("555-1234", "end")
--
-- Strategy:
--   1. parse 3 digits          (pcount 3 pdigit)
--   2. parse a literal '-'     (pchar '-')
--   3. parse 4 digits          (pcount 4 pdigit)
-- and stitch the pieces together with `pseq`. Then convert the
-- digit-lists back to characters: `digit n` -> `chr (cast n + ord '0')`.
--
-- TODO: replace the body of `threeDashFour` with a parser that
--       recognises `\d{3}-\d{4}` and returns the matched 8-character
--       string. The reference solution does:
--         MkParser (\input =>
--           case runParser (pseq (pcount 3 pdigit)
--                                (pseq (pchar '-')
--                                      (pcount 4 pdigit))) input of
--             Just ((a, (_, b)), rest) =>
--                 Just (digitsToStr a ++ "-" ++ digitsToStr b, rest)
--             _ => Nothing)
--
-- where `digitsToStr` is provided below.

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
threeDashFour = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser threeDashFour "555-1234end")
