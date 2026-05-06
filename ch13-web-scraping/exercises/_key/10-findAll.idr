module Main

import Network.HTTP.Client

%default total

-- Exercise 10 key: collect every parser hit.

record HtmlParser a where
  constructor MkHtmlParser
  runHtml : String -> Maybe (a, String)

charP : Char -> HtmlParser Char
charP c = MkHtmlParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

partial
findAll : HtmlParser a -> String -> List a
findAll p s =
  case runHtml p s of
    Just (x, rest) => x :: findAll p rest
    Nothing        =>
      case unpack s of
        []        => []
        (_ :: xs) => findAll p (pack xs)

partial
main : IO ()
main =
  let hits = findAll (charP 'z') "zazbzczd"
  in putStrLn ("findAll found " ++ show (length hits) ++ " 'z's")
