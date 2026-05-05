module Main

import Data.String

%default total

-- New idea: `pcount n p` runs `p` exactly `n` times in sequence and
-- collects the results into a list. If any of the `n` runs fails, the
-- whole `pcount` fails.
--
--     runParser (pcount 3 pdigit) "789hello"
--                                 ==> Just ([7, 8, 9], "hello")
--
-- This is structural recursion on `Nat`. The base case `Z` always
-- succeeds with an empty list. The step case `S k` runs `p` once,
-- then `pcount k p`, and conses.
--
-- TODO: replace the body of `pcount` with two cases:
--         pcount Z     _ = MkParser (\s => Just ([], s))
--         pcount (S k) p = MkParser (\s =>
--           case runParser p s of
--             Nothing       => Nothing
--             Just (x, s1)  =>
--               case runParser (pcount k p) s1 of
--                 Nothing        => Nothing
--                 Just (xs, s2)  => Just (x :: xs, s2))

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pdigit : Parser Integer
pdigit = MkParser (\input =>
  case unpack input of
    (c :: xs) =>
      if isDigit c
        then Just (cast (ord c - ord '0'), pack xs)
        else Nothing
    []        => Nothing)

pcount : Nat -> Parser a -> Parser (List a)
pcount _ _ = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser (pcount 3 pdigit) "789hello")
