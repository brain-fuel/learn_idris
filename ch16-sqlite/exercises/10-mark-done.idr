module Main

import System

%default total

-- New idea: an UPDATE statement is built the same way as INSERT, then
-- shelled out via `sqlite3`. We do not need a transaction here — a
-- single statement is auto-committed.
--
-- Target SQL:  UPDATE tasks SET done = 1 WHERE id = <id>;
--
-- TODO: build the SQL string, wrap it in `sqlite3 <db> "..."`, call
--       `System.system`, and print `marked done: <id>` on success.

markDone : (db : String) -> (id : Int) -> IO ()
markDone _ _ = pure ()

main : IO ()
main = markDone "/tmp/learn_idris_ch16_ex10.db" 1
