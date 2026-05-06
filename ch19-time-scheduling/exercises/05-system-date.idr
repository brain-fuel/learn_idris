module Main

import System

%default total

-- Exercise 05: shell out to `date`
--
-- For human-readable timestamps Idris has no built-in formatter, so
-- the easy route is to delegate: `system "date +%s"` runs the POSIX
-- `date` command and returns its exit code (the OUTPUT goes straight
-- to the parent's stdout because we didn't redirect it).
--
-- TODO: call `System.system "date +%s"` and print the exit code.
-- The numeric epoch will appear above the exit code in the captured
-- driver output.

main : IO ()
main = pure ()
