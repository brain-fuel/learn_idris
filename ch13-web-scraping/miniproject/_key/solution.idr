module Main

import System.File
import Data.String
import Data.Maybe

%default total

------------------------------------------------------------
-- HtmlParser core (cribbed from exercises 01-10).

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

pureP : a -> HtmlParser a
pureP x = MkHtmlParser (\s => Just (x, s))

charP : Char -> HtmlParser Char
charP c = MkHtmlParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

stringP : String -> HtmlParser String
stringP s = MkHtmlParser (go (unpack s)) where
  go : List Char -> String -> Maybe (String, String)
  go []        rest = Just (s, rest)
  go (c :: cs) rest =
    case runHtml (charP c) rest of
      Nothing      => Nothing
      Just (_, r1) => go cs r1

untilTag : HtmlParser String
untilTag = MkHtmlParser (\input =>
  let (text, rest) = break (== '<') (unpack input)
  in Just (pack text, pack rest))

untilQuote : HtmlParser String
untilQuote = MkHtmlParser (\input =>
  let (text, rest) = break (== '"') (unpack input)
  in case rest of
    ('"' :: more) => Just (pack text, pack more)
    _             => Nothing)

partial
findAfter : String -> String -> Maybe String
findAfter needle s =
  case runHtml (stringP needle) s of
    Just (_, rest) => Just rest
    Nothing        =>
      case unpack s of
        []        => Nothing
        (_ :: xs) => findAfter needle (pack xs)

------------------------------------------------------------
-- Targeted extractors for our xkcd snapshot.

partial
extractTitle : String -> Maybe String
extractTitle html = do
  after <- findAfter "<title>" html
  let (text, _) = break (== '<') (unpack after)
  pure (pack text)

partial
extractAttrAfter : String -> String -> String -> Maybe String
extractAttrAfter anchor attr html = do
  after  <- findAfter anchor html
  after2 <- findAfter (attr ++ "=\"") after
  case runHtml untilQuote after2 of
    Just (v, _) => Just v
    Nothing     => Nothing

------------------------------------------------------------

fixturePath : String
fixturePath = "ch13-web-scraping/miniproject/fixtures/xkcd.html"

covering
main : IO ()
main = do
  Right html <- readFile fixturePath
    | Left err => putStrLn ("error: cannot read fixture: " ++ show err)
  let title = fromMaybe "(none)" (extractTitle html)
  let src   = fromMaybe "(none)" (extractAttrAfter "<img" "src" html)
  let alt   = fromMaybe "(none)" (extractAttrAfter "<img" "alt" html)
  putStrLn ("title: " ++ title)
  putStrLn ("image: " ++ src)
  putStrLn ("alt: " ++ alt)
