module Main

%default total

-- Exercise 01: Define an HtmlParser record.
--
-- A parser takes an input String and either fails (returns Nothing) or
-- succeeds with a parsed value plus the remaining unconsumed text.
-- The record below WRAPS that function so we can give it a name.
--
-- TODO: change `runHtml`'s field type from `String -> Maybe (String, String)`
-- to the proper polymorphic type `String -> Maybe (a, String)` so it can
-- carry any value, not just String.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (String, String)

-- A trivial parser-of-Strings that always fails.
noop : HtmlParser String
noop = MkHtmlParser (\_ => Nothing)

main : IO ()
main = putStrLn "FIXME"
