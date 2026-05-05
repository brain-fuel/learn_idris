module Main

import Data.String

%default total

-- New idea: `pmap` transforms the value INSIDE a parser without
-- changing what it consumes. If `p` would have produced `x`, then
-- `pmap f p` produces `f x`. Failures pass through untouched.
--
--     pmap toUpper pany   on   "abc"  ==>  Just ('A', "bc")
--
-- (This is the "Functor" pattern in disguise. We won't use that word
-- yet -- it's just `map` for parsers.)
--
-- TODO: replace the body of `pmap` so that, given `f` and `p`:
--         * run `p` on the input
--         * if it returned `Just (x, rest)`, return `Just (f x, rest)`
--         * if it returned `Nothing`, return `Nothing`
--       case-of on `runParser p input` is the natural shape.

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pany : Parser Char
pany = MkParser (\input =>
  case unpack input of
    (x :: xs) => Just (x, pack xs)
    []        => Nothing)

pmap : (a -> b) -> Parser a -> Parser b
pmap f p = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser (pmap toUpper pany) "abc")
