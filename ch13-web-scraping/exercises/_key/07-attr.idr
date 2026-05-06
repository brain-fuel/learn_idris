module Main

import Data.List

%default total

-- Exercise 07 key: attribute parser.

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

-- read an identifier  [a-zA-Z]+
ident : String -> Maybe (String, String)
ident s =
  case unpack s of
    [] => Nothing
    (c :: _) =>
      if isAlpha c
        then let (a, rest) = break (\x => not (isAlpha x)) (unpack s)
             in Just (pack a, pack rest)
        else Nothing

-- collect everything up to the next '"'
untilQuote : String -> Maybe (String, String)
untilQuote s =
  let (val, rest) = break (== '"') (unpack s)
  in case rest of
    ('"' :: more) => Just (pack val, pack more)
    _             => Nothing

attr : HtmlParser (String, String)
attr = MkHtmlParser (\input =>
  case ident input of
    Nothing       => Nothing
    Just (n, s1)  =>
      case runHtml (charP '=') s1 of
        Nothing      => Nothing
        Just (_, s2) =>
          case runHtml (charP '"') s2 of
            Nothing      => Nothing
            Just (_, s3) =>
              case untilQuote s3 of
                Nothing      => Nothing
                Just (v, s4) => Just ((n, v), s4))

main : IO ()
main = case runHtml attr "src=\"//x.png\" alt=\"...\"" of
  Just ((n, v), r) =>
    putStrLn ("attr " ++ n ++ "=" ++ v ++ ", rest=\"" ++ r ++ "\"")
  Nothing => putStrLn "attr failed"
