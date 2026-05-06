module Main

import System

%default total

-- New idea: `System.system : String -> IO Int` runs a shell command
-- and returns its exit code. `true` is the canonical no-op (always
-- exits 0). We will use the same primitive for `sqlite3 ...` later.
--
-- Disambiguation note: the import also brings `System.Escaped.system`
-- into scope, which takes a `List String`. With a bare String
-- literal both could match via `fromString`, so qualify the call as
-- `System.system "..."`.
--
-- TODO: call `System.system "true"` and print the exit code returned.

main : IO ()
main = pure ()
