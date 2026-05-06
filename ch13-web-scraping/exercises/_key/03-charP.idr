module Main

%default total

-- Exercise 03 key: charP.

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

main : IO ()
main = case runHtml (charP '<') "<html>" of
  Just (c, r) => putStrLn ("charP matched '" ++ pack [c] ++ "', rest=\"" ++ r ++ "\"")
  Nothing     => putStrLn "charP failed unexpectedly"
