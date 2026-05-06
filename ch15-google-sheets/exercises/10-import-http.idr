module Main

import Network.HTTP.Client

%default total

-- Exercise 10: import the HTTP client.
--
-- The `http` pack package gives us `Network.HTTP.Client`. The chapter's
-- `pack.toml` declares the dependency so the import resolves when the
-- Makefile runs `idris2 --check` with `IDRIS2_PACKAGE_PATH` set:
--
--     cd ch15-google-sheets
--     export IDRIS2_PACKAGE_PATH=$(pack package-path)
--     idris2 --check exercises/10-import-http.idr
--
-- The miniproject is a *dry run* — we don't actually open a socket, just
-- print what we would send. So this exercise is just a smoke test that
-- the package resolves.
--
-- TODO: change `note` to "imported HTTP client".

note : String
note = "FIXME"  -- TODO: report that the http pack import resolved

main : IO ()
main = putStrLn note
