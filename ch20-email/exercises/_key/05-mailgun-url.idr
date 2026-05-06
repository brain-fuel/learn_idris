module Main

import Data.String

%default total

-- Exercise 05 key: format the Mailgun messages URL.

mailgunUrl : String -> String
mailgunUrl domain = "https://api.mailgun.net/v3/" ++ domain ++ "/messages"

main : IO ()
main = putStrLn (mailgunUrl "example.com")
