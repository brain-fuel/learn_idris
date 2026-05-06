module Main

import Data.String

%default total

-- Exercise 07: an email has four parts. Capture them in a record, then
-- build a literal value of that record.
--
-- TODO: replace the four `""` placeholders in `sample` with sensible
-- non-empty strings (e.g. `"Ada"`, `"Bob"`, `"hi"`, `"howdy"`). The stub
-- prints `from=` (empty after the equals); the key prints `from=Ada`.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

sample : Message
sample = MkMessage "" "" "" ""

main : IO ()
main = putStrLn ("from=" ++ sample.from)
