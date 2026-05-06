module Main

import Network.HTTP.Client

%default total

-- Exercise 09: confirm that pack-installed `Network.HTTP.Client` is
-- reachable from this chapter. The dry-run mailer never actually
-- POSTs, but a real Mailgun call would use this module. Importing it
-- is enough to verify the pack dep resolves; we don't construct a
-- request here.
--
-- TODO: replace `pure ()` with `putStrLn "http resolved"` so `main`
-- prints a confirmation line. The stub is silent.

main : IO ()
main = pure ()
