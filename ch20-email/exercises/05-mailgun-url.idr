module Main

import Data.String

%default total

-- Exercise 05: build the Mailgun messages URL from a domain name. The
-- format is `https://api.mailgun.net/v3/<domain>/messages`. (Real use
-- would put your sending domain in the slot; the dry-run mailer fills
-- in `example.com`.)
--
-- TODO: replace `mailgunUrl` so it concatenates the three constants
-- around `domain`. The stub returns the empty string.

mailgunUrl : String -> String
mailgunUrl domain = ""

main : IO ()
main = putStrLn (mailgunUrl "example.com")
