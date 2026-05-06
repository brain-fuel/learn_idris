module Main

import System
import System.File
import Data.String
import Data.List1
import Data.List

%default total

-- New idea: assemble exercises 05--08 into one query. Shell out a
-- `SELECT` redirected to a tempfile, read the tempfile, parse TSV,
-- map each row into a `Task`. Returns `List Task`. Stub returns `[]`.
--
-- TODO: build the SELECT command (use `-separator $'\t'`), run it,
--       read the tempfile, split into rows, drop empties, map
--       `rowToTask`. Wrap any IO error path with a sensible default.

record Task where
  constructor MkTask
  id    : Int
  title : String
  done  : Int

showTask : Task -> String
showTask t = "id=" ++ show t.id ++ " title=" ++ t.title ++ " done=" ++ show t.done

splitRow : String -> List String
splitRow row = forget (split (== '\t') row)

rowToTask : List String -> Task
rowToTask [i, t, d] = MkTask (cast i) t (cast d)
rowToTask _         = MkTask 0 "" 0

covering
listTasks : (db : String) -> IO (List Task)
listTasks db = pure []

covering
main : IO ()
main = do
  tasks <- listTasks "/tmp/learn_idris_ch16_ex09.db"
  for_ tasks (\t => putStrLn (showTask t))
