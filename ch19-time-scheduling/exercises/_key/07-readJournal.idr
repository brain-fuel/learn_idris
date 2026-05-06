module Main

import System.File
import Data.String

%default total

journalPath : String
journalPath = "ch19-time-scheduling/miniproject/fixtures/journal.txt"

covering
readJournal : IO (List String)
readJournal = do
  Right text <- readFile journalPath
    | Left _ => pure []
  pure (filter (/= "") (lines text))

covering
main : IO ()
main = do
  ls <- readJournal
  for_ ls putStrLn
