module Main

import Network.HTTP.Client

%default total

-- Exercise 10: `findAll p s` returns every match of `p` in `s`.
--
-- TODO: replace the placeholder body. The placeholder always returns
-- the empty list. Implement `findAll` by sliding along `s`: try `p`
-- at the current offset, on success record the match and skip past
-- the matched portion, on failure advance one character.

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
findAll _ _ = []

main : IO ()
main = putStrLn "FIXME"
