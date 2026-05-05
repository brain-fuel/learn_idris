module Main

import Data.String

%default total

-- New idea: `pseq` runs two parsers in order. First `p`; if it
-- succeeds with `(x, rest1)`, then run `q` on `rest1`. If both succeed
-- you get back `((x, y), rest2)`. If either fails, the whole thing
-- fails.
--
--     pseq (pchar 'h') (pchar 'i')   on   "hi!"
--                                ==> Just (('h', 'i'), "!")
--
-- This is how parsers compose along the input -- one after the other,
-- threading the leftover string.
--
-- TODO: replace the body of `pseq` so it:
--         * runs `p` on the input; if Nothing, return Nothing
--         * else runs `q` on the leftover; if Nothing, return Nothing
--         * else returns `Just ((x, y), rest2)`
--       Two nested case-of expressions handle this cleanly.

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pchar : Char -> Parser Char
pchar c = MkParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

pseq : Parser a -> Parser b -> Parser (a, b)
pseq p q = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser (pseq (pchar 'h') (pchar 'i')) "hi!")
