module Main

%default total

-- Exercise 05 key: many.

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

partial
many : HtmlParser a -> HtmlParser (List a)
many p = MkHtmlParser (go) where
  partial
  go : String -> Maybe (List a, String)
  go s =
    case runHtml p s of
      Nothing      => Just ([], s)
      Just (x, s1) =>
        case go s1 of
          Nothing       => Just ([x], s1)
          Just (xs, s2) => Just (x :: xs, s2)

partial
main : IO ()
main = case runHtml (many (charP 'a')) "aaab" of
  Just (xs, r) => putStrLn ("many matched " ++ show (length xs) ++
                            " 'a's, rest=\"" ++ r ++ "\"")
  Nothing      => putStrLn "many failed"
