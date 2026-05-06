module Main

%default total

-- Exercise 02 key: pure for HtmlParser.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

pureP : a -> HtmlParser a
pureP x = MkHtmlParser (\s => Just (x, s))

main : IO ()
main = case runHtml (pureP "ok") "rest" of
  Just (v, r) => putStrLn ("pure produced \"" ++ v ++ "\" with rest \"" ++ r ++ "\"")
  Nothing     => putStrLn "pure unexpectedly failed"
