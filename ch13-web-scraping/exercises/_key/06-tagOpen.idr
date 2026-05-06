module Main

%default total

-- Exercise 06 key: tagOpen.

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

stringP : String -> HtmlParser String
stringP s = MkHtmlParser (go (unpack s)) where
  go : List Char -> String -> Maybe (String, String)
  go []        rest = Just (s, rest)
  go (c :: cs) rest =
    case runHtml (charP c) rest of
      Nothing       => Nothing
      Just (_, r1)  => go cs r1

tagOpen : String -> HtmlParser String
tagOpen name = MkHtmlParser (\input =>
  case runHtml (charP '<') input of
    Nothing      => Nothing
    Just (_, s1) =>
      case runHtml (stringP name) s1 of
        Nothing      => Nothing
        Just (_, s2) =>
          case runHtml (charP '>') s2 of
            Nothing      => Nothing
            Just (_, s3) => Just (name, s3))

main : IO ()
main = case runHtml (tagOpen "title") "<title>xkcd</title>" of
  Just (n, r) => putStrLn ("tagOpen matched <" ++ n ++ ">, rest=\"" ++ r ++ "\"")
  Nothing     => putStrLn "tagOpen failed"
