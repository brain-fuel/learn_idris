module Main

%default total

-- Exercise 04: `stringP s` matches the literal string `s`.
--
-- TODO: implement `stringP` by folding `charP` over the characters of `s`.
-- The placeholder body just returns the empty string regardless of input.

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
stringP _ = pureP ""

main : IO ()
main = putStrLn "FIXME"
