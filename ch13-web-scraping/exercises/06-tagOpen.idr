module Main

%default total

-- Exercise 06: `tagOpen name` matches an opening tag like `<title>`.
--
-- That's literally `<` then the tag name then `>`. We can compose
-- charP and stringP to do it.
--
-- TODO: replace the placeholder body so `tagOpen "title"` actually
-- consumes "<title>" off the front of input. The placeholder always
-- succeeds with the empty string but consumes nothing.

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
      Nothing       => Nothing
      Just (_, r1)  => go cs r1

tagOpen : String -> HtmlParser String
tagOpen _ = pureP ""

main : IO ()
main = putStrLn "FIXME"
