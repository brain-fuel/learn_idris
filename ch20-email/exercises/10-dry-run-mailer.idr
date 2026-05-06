module Main

import Data.String
import Data.List

%default total

-- Exercise 10: tie everything together. A `Mailer` knows whether to
-- actually POST or just print, plus the API key. `runMailer` should
-- print the three lines a dry-run sends to stdout:
--
--   POST https://api.mailgun.net/v3/example.com/messages
--   Authorization: Bearer <key>
--   Body: from=...&to=...&subject=...&text=...
--
-- (When `dryRun = False` the real version would POST. We're staying
-- offline for the whole chapter, so `runMailer` always prints.)
--
-- TODO: replace `runMailer` so it prints the three lines above using
-- the helpers below. The stub prints `FIXME`.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

record Mailer where
  constructor MkMailer
  dryRun : Bool
  key    : String

formField : (String, String) -> String
formField (k, v) = k ++ "=" ++ v

formFields : List (String, String) -> String
formFields ps = joinBy "&" (map formField ps)

mailgunUrl : String -> String
mailgunUrl domain = "https://api.mailgun.net/v3/" ++ domain ++ "/messages"

messageToForm : Message -> List (String, String)
messageToForm m =
  [ ("from"   , m.from)
  , ("to"     , m.to)
  , ("subject", m.subject)
  , ("text"   , m.body)
  ]

runMailer : Mailer -> Message -> IO ()
runMailer mailer msg = putStrLn "FIXME"

main : IO ()
main =
  let mailer = MkMailer True "FAKE_KEY"
      msg    = MkMessage "Ada" "Bob" "hi" "howdy"
  in runMailer mailer msg
