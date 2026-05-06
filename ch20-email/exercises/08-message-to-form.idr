module Main

import Data.String

%default total

-- Exercise 08: convert a `Message` record into the `[(k, v)]` shape that
-- `formFields` (ex 04) expects. Note: Mailgun calls the plaintext body
-- field `text`, NOT `body`, so map `m.body` to the key `"text"`.
--
-- TODO: replace `messageToForm` so it returns the four pairs
--   [("from", m.from), ("to", m.to), ("subject", m.subject), ("text", m.body)]
-- The stub returns the empty list, which prints `0` for the length.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

messageToForm : Message -> List (String, String)
messageToForm m = []

sample : Message
sample = MkMessage "Ada" "Bob" "hi" "howdy"

main : IO ()
main = printLn (length (messageToForm sample))
