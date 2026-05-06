module Main

import System
import System.File
import Data.String
import Data.List1
import Data.List

%default total

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

tmpPath : String
tmpPath = "/tmp/learn_idris_ch16_ex09_out.tsv"

covering
listTasks : (db : String) -> IO (List Task)
listTasks db = do
  let cmd = "sqlite3 -separator '\t' " ++ db ++
            " 'SELECT id, title, done FROM tasks ORDER BY id;' > " ++
            tmpPath
  _ <- System.system cmd
  Right contents <- readFile tmpPath
    | Left _ => pure []
  let lines    = forget (split (== '\n') contents)
  let nonEmpty = filter (\l => l /= "") lines
  pure (map (rowToTask . splitRow) nonEmpty)

covering
main : IO ()
main = do
  -- demo (no DB seeded here): listTasks returns [] but the function compiles
  tasks <- listTasks "/tmp/learn_idris_ch16_ex09.db"
  for_ tasks (\t => putStrLn (showTask t))
  putStrLn "list-tasks ok"
