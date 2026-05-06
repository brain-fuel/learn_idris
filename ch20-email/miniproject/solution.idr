module Main

import Data.String
import Data.List
import Data.Maybe

%default total

-- `mailer --dry-run`: a transactional-email POST you can SEE before
-- sending it. Real Mailgun would `requests.post(...)` to
-- `https://api.mailgun.net/v3/<domain>/messages` with HTTP basic auth
-- (or bearer) and a form body containing `from`, `to`, `subject`,
-- and `text` (the plaintext body). Here we just construct the same
-- pieces and print them — three lines, deterministic, no network.
--
-- Why stdin? `idris2 --exec main` does not pass argv through, so
-- every chapter takes its config on stdin. This solution reads ONE
-- line, formatted as four space-separated `key=value` tokens:
--
--     from=Ada to=Bob subject=hi body=howdy
--
-- and prints exactly:
--
--     POST https://api.mailgun.net/v3/example.com/messages
--     Authorization: Bearer FAKE_KEY
--     Body: from=Ada&to=Bob&subject=hi&text=howdy
--
-- Note `text=howdy`, NOT `body=howdy`. Mailgun calls the plaintext
-- field `text`. The input uses `body=` because that's the natural
-- word; the OUTPUT does the rename.
--
-- TODO 1: parse the four `key=value` tokens out of the input line.
--         A simple way: `words` to split on spaces, then split each
--         token on `=` (use `Data.String.split (== '=')` and `forget`
--         to convert the `List1` to a `List`).
-- TODO 2: build a `Message` record from the four values.
-- TODO 3: print the three expected lines using `formFields` and the
--         `mailgunUrl` / `bearerHeader` helpers (define them inline
--         here — copy from the exercises).
--
-- Expected stdout substrings the driver checks for:
--   "POST", "from=", "to=", "subject=", "text="
--
-- The stub prints `FIXME` lines instead — driver fails on a fresh
-- clone, intended.

main : IO ()
main = do
  _ <- getLine
  putStrLn "FIXME url"
  putStrLn "FIXME header"
  putStrLn "FIXME body"
