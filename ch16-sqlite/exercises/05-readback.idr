module Main

import System
import System.File

%default total

-- New idea: to capture command output, redirect stdout to a tempfile
-- inside the shell command, then `readFile` the tempfile. This is the
-- pattern we will use to read SELECT results back from `sqlite3`.
--
-- TODO: shell out `echo hello > /tmp/learn_idris_ch16_ex05.txt`,
--       then read that file and print its contents (without a final
--       newline added by us — `putStr`, not `putStrLn`).

covering
readback : IO ()
readback = pure ()

main : IO ()
main = readback
