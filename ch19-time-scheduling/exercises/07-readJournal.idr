module Main

import System.File
import Data.String

%default total

-- Exercise 07: read a journal file into a list of lines.
--
-- The journal is `ch19-time-scheduling/miniproject/fixtures/journal.txt`.
-- Each line looks like `09:00 start`.
--
-- The Idris idiom is:
--
--     Right text <- readFile path
--       | Left err => ...
--     let ls = lines text
--
-- TODO: implement `readJournal` so it reads the file and returns the
-- list of lines. On error, return `[]`. Mark it `covering` because
-- `readFile` is `covering`.

journalPath : String
journalPath = "ch19-time-scheduling/miniproject/fixtures/journal.txt"

covering
readJournal : IO (List String)
readJournal = pure []

covering
main : IO ()
main = do
  ls <- readJournal
  for_ ls putStrLn
