module Main

import System.File

%default total

-- New idea: `readFile : String -> IO (Either FileError String)`. The
-- result is wrapped in `Either` because opening a file can fail (no
-- such path, no permission). The Idris idiom for handling that is the
-- `with-pattern <-` form:
--
--     Right s <- readFile path
--       | Left err => putStrLn "could not open file"
--     putStr s
--
-- The line `| Left err => ...` is the "if the pattern on the left did
-- NOT match" branch. It is the typed equivalent of Python's `try/except`.
--
-- TODO: replace `FIXME` so the program reads
--       `ch10-files/exercises/fixtures/hello.txt` and prints its contents
--       with `putStr`. On error, print `could not open file`.
--       (Hint: paths are relative to the repo root, since the test
--       runner invokes Idris from there.)

main : IO ()
main = putStrLn "FIXME"
