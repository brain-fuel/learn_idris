module Main

import System.File

%default total

-- New idea: `appendFile : String -> String -> IO (Either FileError ())`
-- adds to the END of an existing file (or creates it if missing). Use it
-- when you want to grow a log without losing what's already there.
--
-- The program below first wipes the target file with `writeFile path ""`,
-- so reruns are deterministic.
--
-- TODO: after the wipe, call `appendFile` TWICE on `path` -- first with
--       `"line A\n"`, then with `"line B\n"`. Then `readFile path` and
--       print the result with `putStr`. Expected output:
--           line A
--           line B
--       On any error, print `error: <show err>`.

path : String
path = "/tmp/learn_idris_ch10_ex03.txt"

main : IO ()
main = pure ()
