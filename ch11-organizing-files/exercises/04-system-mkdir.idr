module Main

import System

%default total

-- New idea: `System.system : String -> IO Int` runs a shell command and
-- gives you back its exit code. When `System.Directory` doesn't ship
-- the operation you want (e.g., recursive `mkdir -p`), shell out.
-- Idris doesn't pretend to wrap every coreutil — that's fine.
--
-- TODO: call `system "mkdir -p /tmp/learn_idris_ch11_ex04/sub/sub"` and
--       print the exit code. Then print `ok` if exit code was 0; else
--       `not ok`.

main : IO ()
main = do
  printLn (-1)
  putStrLn "not ok"
