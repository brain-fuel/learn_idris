module Main

import Data.String
import System.File
import System.File.Virtual

%default total

------------------------------------------------------------
-- Tiny parser-combinator core (copied from the exercises).

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

------------------------------------------------------------
-- The phone-number parser: \d{3}-\d{3}-\d{4}.

phone : Parser String
phone = MkParser go where
  go : String -> Maybe (String, String)
  go s =
    case runParser (pcount 3 pdigit) s of
      Nothing      => Nothing
      Just (a, s1) =>
        case runParser (pchar '-') s1 of
          Nothing      => Nothing
          Just (_, s2) =>
            case runParser (pcount 3 pdigit) s2 of
              Nothing      => Nothing
              Just (b, s3) =>
                case runParser (pchar '-') s3 of
                  Nothing      => Nothing
                  Just (_, s4) =>
                    case runParser (pcount 4 pdigit) s4 of
                      Nothing      => Nothing
                      Just (c, s5) =>
                        Just (digitsToStr a ++ "-" ++
                              digitsToStr b ++ "-" ++
                              digitsToStr c, s5)

------------------------------------------------------------
-- Sliding scan: try `phone` at each position; on a hit, skip the
-- 12 matched chars; otherwise advance by one.

partial
findAll : List Char -> List String
findAll [] = []
findAll cs@(_ :: rest) =
  case runParser phone (pack cs) of
    Just (m, _) => m :: findAll (drop (length (unpack m)) cs)
    Nothing     => findAll rest

------------------------------------------------------------
-- Slurp all of stdin, line by line, until EOF.

partial
readAll : IO String
readAll = go "" where
  partial
  go : String -> IO String
  go acc = do
    eof <- fEOF stdin
    if eof
      then pure acc
      else do
        l <- getLine
        go (acc ++ l ++ "\n")

partial
main : IO ()
main = do
  contents <- readAll
  for_ (findAll (unpack contents)) putStrLn
