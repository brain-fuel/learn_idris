module Main

import System
import System.File
import Data.String
import Data.List1
import Data.List

%default total

-- Task tracker starter file.
--
-- Behavior: read commands from stdin one line at a time and dispatch
-- to a sqlite3-backed `tasks` table at `dbPath` (the test driver
-- creates the table beforehand).
--
--   add <title>   -- INSERT a row with done=0; print "added: <title>"
--   list          -- SELECT *; print one line per row:
--                      id=<n> title=<t> done=<d>
--   done <id>     -- UPDATE done=1 WHERE id=<id>; print "marked done: <id>"
--   quit          -- print "quit" and stop. Empty line also stops (EOF).
--
-- Why `partial`: the REPL loop recurses on user input, not a
-- structurally smaller value, so Idris cannot prove it terminates.
-- `main` is `partial` because it calls a `partial` function.
--
-- TODO 1: complete `addTask` -- shell out
--           sqlite3 <dbPath> "INSERT INTO tasks(title, done) VALUES('<title>', 0);"
--         then print "added: <title>".
-- TODO 2: complete `listTasks` -- shell out a SELECT redirected to
--         `tmpPath`, read it back, parse TSV (split on '\n' then
--         '\t'), and for each row print
--           id=<n> title=<t> done=<d>
-- TODO 3: complete `markDone` -- shell out an UPDATE; print
--           "marked done: <id>"

dbPath : String
dbPath = "/tmp/learn_idris_ch16_tasks.db"

tmpPath : String
tmpPath = "/tmp/learn_idris_ch16_tasks_list.tsv"

addTask : String -> IO ()
addTask _ = putStrLn "FIXME add"

covering
listTasks : IO ()
listTasks = putStrLn "FIXME list"

markDone : String -> IO ()
markDone _ = putStrLn "FIXME done"

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
