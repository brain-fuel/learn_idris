module Main

import Data.String

%default total

-- New idea: `many p` keeps running `p` as many times as possible, and
-- gathers all the results into a list. It NEVER FAILS -- if `p` doesn't
-- match even once, you get back `Just ([], input)`.
--
--     runParser (many pdigit) "123abc"  ==>  Just ([1, 2, 3], "abc")
--     runParser (many pdigit) "abc"     ==>  Just ([], "abc")
--
-- WHY IS THIS `partial`? Idris's totality checker can't see why this
-- terminates: if `p` could ever succeed without consuming input, we'd
-- loop forever. With the parsers we've built so far that won't happen
-- in practice, but the checker doesn't know that. Same situation as
-- the REPL loop in chapter 7: we mark it `partial` and move on.
--
-- TODO: replace the body of `go` with this structure:
--         go s = case runParser p s of
--                  Nothing      => Just ([], s)
--                  Just (x, s1) =>
--                    case go s1 of
--                      Just (xs, s2) => Just (x :: xs, s2)
--                      Nothing       => Just ([x], s1)
--
-- Leave the two `partial` annotations alone -- they're already there.

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

partial
many : Parser a -> Parser (List a)
many p = MkParser (\_ => Nothing)

partial
main : IO ()
main = printLn (runParser (many pdigit) "123abc")
