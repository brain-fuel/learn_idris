module Main

%default total

-- Exercise 02: `pure` for HtmlParser.
--
-- `pure x` should be a parser that consumes nothing and always succeeds
-- with `x`, leaving the input untouched.
--
-- TODO: replace the body of `pureP` so it returns
--   MkHtmlParser (\s => Just (x, s))
-- The current body always FAILS, which is wrong.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

pureP : a -> HtmlParser a
pureP x = MkHtmlParser (\_ => Nothing)

main : IO ()
main = putStrLn "FIXME"
