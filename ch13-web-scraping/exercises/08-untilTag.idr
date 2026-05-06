module Main

%default total

-- Exercise 08: `untilTag` collects characters until the next '<'.
--
-- This is how we extract the text inside `<title>...</title>`.
--
-- TODO: replace the placeholder body so it consumes characters from
-- input up to (but not including) the next '<'. The placeholder hands
-- back the empty string and consumes nothing.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

pureP : a -> HtmlParser a
pureP x = MkHtmlParser (\s => Just (x, s))

untilTag : HtmlParser String
untilTag = pureP ""

main : IO ()
main = putStrLn "FIXME"
