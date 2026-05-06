module Main

import Network.HTTP.Client

%default total

-- Exercise 09 key: try parser at every offset.

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
findOne p s =
  case runHtml p s of
    Just (x, _) => Just x
    Nothing     =>
      case unpack s of
        []        => Nothing
        (_ :: xs) => findOne p (pack xs)

partial
main : IO ()
main = case findOne (charP 'z') "abcz123" of
  Just c  => putStrLn ("findOne hit '" ++ pack [c] ++ "'")
  Nothing => putStrLn "findOne missed"
