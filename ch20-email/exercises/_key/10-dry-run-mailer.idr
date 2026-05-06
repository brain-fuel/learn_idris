module Main

import Data.String
import Data.List

%default total

-- Exercise 10 key: print the would-be POST.

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
runMailer mailer msg = do
  putStrLn ("POST " ++ mailgunUrl "example.com")
  putStrLn ("Authorization: Bearer " ++ mailer.key)
  putStrLn ("Body: " ++ formFields (messageToForm msg))

main : IO ()
main =
  let mailer = MkMailer True "FAKE_KEY"
      msg    = MkMessage "Ada" "Bob" "hi" "howdy"
  in runMailer mailer msg
