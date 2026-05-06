module Main

import Data.String

%default total

-- Exercise 07 key: build a Message literal with real fields.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

sample : Message
sample = MkMessage "Ada" "Bob" "hi" "howdy"

main : IO ()
main = putStrLn ("from=" ++ sample.from)
