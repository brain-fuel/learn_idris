module Main

import Data.String

%default total

-- Exercise 08 key: project the four record fields into Mailgun keys.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

messageToForm : Message -> List (String, String)
messageToForm m =
  [ ("from"   , m.from)
  , ("to"     , m.to)
  , ("subject", m.subject)
  , ("text"   , m.body)
  ]

sample : Message
sample = MkMessage "Ada" "Bob" "hi" "howdy"

main : IO ()
main = printLn (length (messageToForm sample))
