module Main

import System.File
import Data.String

%default total

-- New idea: factor the read-and-split-into-lines pattern into a small
-- helper that hides the `Either FileError`. Caller signature:
--
--     readLines : String -> IO (List String)
--
-- On success -> `lines` of the contents. On failure -> empty list.
-- This is the file-IO analogue of `dict.get(key, default)`: turn an
-- error case into a sensible default so the caller stays simple.
--
-- TODO: replace the body of `readLines` so it pattern-matches on
--       `readFile path` and returns `lines contents` on `Right`,
--       `[]` on `Left`.

readLines : String -> IO (List String)
readLines _ = pure []

main : IO ()
main = do
  xs <- readLines "ch10-files/exercises/fixtures/three-lines.txt"
  printLn xs
