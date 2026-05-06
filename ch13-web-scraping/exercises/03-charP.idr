module Main

%default total

-- Exercise 03: `charP c` matches the character `c` at the head of input.
--
-- TODO: rewrite `charP` so that it inspects the first character of the
-- input string and returns `Just (c, rest)` if it equals `c`, or
-- `Nothing` otherwise. The current placeholder always succeeds with 'x'.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

pureP : a -> HtmlParser a
pureP x = MkHtmlParser (\s => Just (x, s))

charP : Char -> HtmlParser Char
charP c = pureP 'x'

main : IO ()
main = putStrLn "FIXME"
