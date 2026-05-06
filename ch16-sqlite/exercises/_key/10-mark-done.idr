module Main

import System

%default total

markDone : (db : String) -> (id : Int) -> IO ()
markDone db id = do
  let sql = "UPDATE tasks SET done = 1 WHERE id = " ++ show id ++ ";"
  let cmd = "sqlite3 " ++ db ++ " \"" ++ sql ++ "\""
  _ <- System.system cmd
  putStrLn ("marked done: " ++ show id)

main : IO ()
main = markDone "/tmp/learn_idris_ch16_ex10.db" 1
