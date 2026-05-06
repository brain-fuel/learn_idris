module Main

import Data.String

%default total

-- Exercise 01: a Mailgun POST body is `from=Ada&to=Bob&subject=hi&text=howdy`.
-- Each piece is one `key=value` pair. Start with the smallest unit: turn a
-- single `(String, String)` pair into the string `key=value`.
--
-- TODO: replace the body of `formField` so it returns `k ++ "=" ++ v`.
-- The stub returns `""`, which makes `main` print an empty line.

formField : (String, String) -> String
formField (k, v) = ""

main : IO ()
main = putStrLn (formField ("from", "Ada"))
