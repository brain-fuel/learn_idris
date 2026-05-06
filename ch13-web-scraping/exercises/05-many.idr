module Main

%default total

-- Exercise 05: `many p` runs `p` greedily, collecting every result.
--
-- Because the recursion isn't structural (we recurse on whatever input
-- `p` leaves behind), the helper must be marked `partial`.
--
-- TODO: rewrite `many` so it actually loops. The placeholder always
-- returns the empty list without trying `p` even once.

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

partial
many : HtmlParser a -> HtmlParser (List a)
many p = pureP []

main : IO ()
main = putStrLn "FIXME"
