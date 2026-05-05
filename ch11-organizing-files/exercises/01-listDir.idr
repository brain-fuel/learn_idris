module Main

import System.Directory

%default total

-- New idea: `listDir : String -> IO (Either FileError (List String))`
-- returns the entries of a directory, with `.` and `..` already
-- excluded. On failure (path doesn't exist, not readable, ...) you get
-- a `Left FileError`.
--
-- TODO: replace `FIXME` so you `listDir
--       "ch11-organizing-files/exercises/fixtures/dir01"` and `printLn`
--       the result. On `Left`, print `could not list`.

main : IO ()
main = putStrLn "FIXME"
