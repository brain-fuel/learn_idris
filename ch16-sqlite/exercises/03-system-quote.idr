module Main

%default total

-- New idea: to run SQL via the `sqlite3` CLI we wrap our INSERT in
--    sqlite3 file.db "INSERT ...;"
-- The outer double-quotes group the SQL into one shell argument.
--
-- TODO: build the full command string. Given a database path and a
--       SQL fragment, return:
--           sqlite3 <db> "<sql>"
--       (Note the double quotes around <sql>.)

buildCmd : (db : String) -> (sql : String) -> String
buildCmd db sql = ""

main : IO ()
main = putStrLn (buildCmd "tasks.db" "INSERT INTO tasks(title) VALUES('foo');")
