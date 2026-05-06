module Main

import Data.String
import Data.List
import Data.List1
import Data.Maybe

%default total

-- Reference solution for the dry-run mailer.

record Message where
  constructor MkMessage
  from    : String
  to      : String
  subject : String
  body    : String

defaultMessage : Message
defaultMessage = MkMessage "" "" "" ""

formField : (String, String) -> String
formField (k, v) = k ++ "=" ++ v

formFields : List (String, String) -> String
formFields ps = joinBy "&" (map formField ps)

mailgunUrl : String -> String
mailgunUrl domain = "https://api.mailgun.net/v3/" ++ domain ++ "/messages"

bearerHeader : String -> (String, String)
bearerHeader key = ("Authorization", "Bearer " ++ key)

messageToForm : Message -> List (String, String)
messageToForm m =
  [ ("from"   , m.from)
  , ("to"     , m.to)
  , ("subject", m.subject)
  , ("text"   , m.body)
  ]

-- Split one `key=value` token into a (k, v) pair. Anything malformed
-- becomes ("", token).
parseToken : String -> (String, String)
parseToken s =
  case forget (split (== '=') s) of
    (k :: v :: _) => (k, v)
    _             => ("", s)

applyPair : (String, String) -> Message -> Message
applyPair ("from"   , v) m = { from    := v } m
applyPair ("to"     , v) m = { to      := v } m
applyPair ("subject", v) m = { subject := v } m
applyPair ("body"   , v) m = { body    := v } m
applyPair _              m = m

buildMessage : List (String, String) -> Message
buildMessage = foldr applyPair defaultMessage

main : IO ()
main = do
  line <- getLine
  let pairs = map parseToken (words line)
  let msg   = buildMessage pairs
  let (hName, hValue) = bearerHeader "FAKE_KEY"
  putStrLn ("POST " ++ mailgunUrl "example.com")
  putStrLn (hName ++ ": " ++ hValue)
  putStrLn ("Body: " ++ formFields (messageToForm msg))
