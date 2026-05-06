module Main

import System.File
import Data.String
import Data.List
import Data.List1

%default total

-- Miniproject: clock-report
--
-- Read `ch19-time-scheduling/miniproject/fixtures/journal.txt`.
-- Each line is `HH:MM <event>`. Print, for each consecutive pair:
--
--   09:00 -> 09:25 (25 min) start
--
-- Then a final line:
--
--   total: 105 min
--
-- The event label on each line is from the FIRST timestamp of the pair.
-- The last line in the journal acts only as the closing timestamp.
--
-- TODO (learner): replace the FIXME body so it produces the report.
-- Use exercises 06-10 as building blocks.

journalPath : String
journalPath = "ch19-time-scheduling/miniproject/fixtures/journal.txt"

covering
main : IO ()
main = do
  putStrLn "FIXME 0 -> FIXME 0 (FIXME min) FIXME"
  putStrLn "total: 0 min"
