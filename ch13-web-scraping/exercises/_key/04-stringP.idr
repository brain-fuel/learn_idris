module Main

%default total

-- Exercise 04 key: stringP folds charP across the literal.

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

main : IO ()
main = case runHtml (stringP "<title>") "<title>hi</title>" of
  Just (m, r) => putStrLn ("stringP matched \"" ++ m ++ "\", rest=\"" ++ r ++ "\"")
  Nothing     => putStrLn "stringP failed"
