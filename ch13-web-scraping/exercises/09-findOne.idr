module Main

import Network.HTTP.Client

%default total

-- Exercise 09: `findOne p s` searches the string `s` for the first place
-- where parser `p` matches. (We import Network.HTTP.Client to demonstrate
-- where the matched HTML would come from in a real scrape; the import
-- itself is enough — we don't perform the request here.)
--
-- TODO: replace `findOne` so it tries `p` at offset 0, 1, 2, ... and
-- returns the first hit (or Nothing). The placeholder always returns
-- Nothing.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

charP : Char -> HtmlParser Char
charP c = MkHtmlParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

partial
findOne : HtmlParser a -> String -> Maybe a
findOne _ _ = Nothing

main : IO ()
main = putStrLn "FIXME"
