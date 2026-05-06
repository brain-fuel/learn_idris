module Main

%default total

-- Exercise 01 key: HtmlParser record.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

-- A trivial parser that always fails (works for any `a`).
noop : HtmlParser a
noop = MkHtmlParser (\_ => Nothing)

main : IO ()
main = case runHtml (the (HtmlParser Char) noop) "hi" of
  Nothing => putStrLn "noop failed (as expected)"
  Just _  => putStrLn "noop unexpectedly matched"
