module Main

%default total

-- Exercise 07: parse a single HTML attribute  name="value".
--
-- We split on `=` and `"` to recover the (name, value) pair.
--
-- TODO: replace the placeholder body so `attr` actually walks the input
-- and returns `Just ((name, value), rest)`. The placeholder hands back
-- the empty pair regardless.

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

attr : HtmlParser (String, String)
attr = pureP ("", "")

main : IO ()
main = putStrLn "FIXME"
