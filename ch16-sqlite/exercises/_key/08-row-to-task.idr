module Main

import Data.String

%default total

record Task where
  constructor MkTask
  id    : Int
  title : String
  done  : Int

showTask : Task -> String
showTask t = "id=" ++ show t.id ++ " title=" ++ t.title ++ " done=" ++ show t.done

rowToTask : List String -> Task
rowToTask [i, t, d] = MkTask (cast i) t (cast d)
rowToTask _         = MkTask 0 "" 0

main : IO ()
main = putStrLn (showTask (rowToTask ["1", "laundry", "0"]))
