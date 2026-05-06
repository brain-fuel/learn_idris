module Main

import Data.List

%default total

-- Exercise 08 key: collect chars until next '<'.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

untilTag : HtmlParser String
untilTag = MkHtmlParser (\input =>
  let (text, rest) = break (== '<') (unpack input)
  in Just (pack text, pack rest))

main : IO ()
main = case runHtml untilTag "Hello world<br>more" of
  Just (t, r) => putStrLn ("untilTag took \"" ++ t ++ "\", rest=\"" ++ r ++ "\"")
  Nothing     => putStrLn "untilTag failed"
