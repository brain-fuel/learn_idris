module Main

import System.File

%default total

-- New idea: `writeFile : String -> String -> IO (Either FileError ())`.
-- The first argument is the PATH, the second is the CONTENTS. Like
-- `readFile`, it returns `Either FileError ...` because the write can
-- fail.
--
-- TODO: replace `FIXME` with a `writeFile` call that writes the literal
--       text `saved!` to `/tmp/learn_idris_ch10_ex02.txt`. On success,
--       print `wrote it`. On failure, print `error: <show err>`.

main : IO ()
main = putStrLn "FIXME -- implement write"
