module Main

import Data.String

%default total

-- New idea: now that we have rows as `List String`, give each row a
-- structured type. A `record Task` packs the three columns together;
-- subsequent code talks about `t.title` instead of `index 1 row`.
--
-- TODO: in `rowToTask`, take a row of three strings and build a
--       `Task` with `title` from the second column and `done` parsed
--       from the third (use `cast` to turn String into Int). Use 0
--       defaults on a malformed row.

record Task where
  constructor MkTask
  id    : Int
  title : String
  done  : Int

showTask : Task -> String
showTask t = "id=" ++ show t.id ++ " title=" ++ t.title ++ " done=" ++ show t.done

rowToTask : List String -> Task
rowToTask _ = MkTask 0 "FIXME" 0

main : IO ()
main = putStrLn (showTask (rowToTask ["1", "laundry", "0"]))
