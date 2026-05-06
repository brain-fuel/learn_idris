module Main

import System
import System.File
import Data.String
import Data.List1
import Data.List

%default total

dbPath : String
dbPath = "/tmp/learn_idris_ch16_tasks.db"

tmpPath : String
tmpPath = "/tmp/learn_idris_ch16_tasks_list.tsv"

quoteChar : Char -> String
quoteChar '\'' = "''"
quoteChar c    = singleton c

quoteSql : String -> String
quoteSql s = concatMap quoteChar (unpack s)

addTask : String -> IO ()
addTask title = do
  let sql = "INSERT INTO tasks(title, done) VALUES('" ++
            quoteSql title ++ "', 0);"
  let cmd = "sqlite3 " ++ dbPath ++ " \"" ++ sql ++ "\""
  _ <- System.system cmd
  putStrLn ("added: " ++ title)

splitRow : String -> List String
splitRow row = forget (split (== '\t') row)

printRow : List String -> IO ()
printRow [i, t, d] =
  putStrLn ("id=" ++ i ++ " title=" ++ t ++ " done=" ++ d)
printRow _ = pure ()

covering
listTasks : IO ()
listTasks = do
  let cmd = "sqlite3 -separator '\t' " ++ dbPath ++
            " 'SELECT id, title, done FROM tasks ORDER BY id;' > " ++
            tmpPath
  _ <- System.system cmd
  Right contents <- readFile tmpPath
    | Left e => putStrLn ("error: " ++ show e)
  let lines    = forget (split (== '\n') contents)
  let nonEmpty = filter (\l => l /= "") lines
  for_ nonEmpty (\l => printRow (splitRow l))

markDone : String -> IO ()
markDone idStr = do
  let sql = "UPDATE tasks SET done = 1 WHERE id = " ++ idStr ++ ";"
  let cmd = "sqlite3 " ++ dbPath ++ " \"" ++ sql ++ "\""
  _ <- System.system cmd
  putStrLn ("marked done: " ++ idStr)

partial
loop : IO ()
loop = do
  line <- getLine
  let toks = words line
  case toks of
    [] => pure ()
    ["quit"] => putStrLn "quit"
    ["list"] => do listTasks; loop
    ("add" :: rest) => do addTask (unwords rest); loop
    ["done", n] => do markDone n; loop
    _ => do putStrLn "?"; loop

partial
main : IO ()
main = loop
