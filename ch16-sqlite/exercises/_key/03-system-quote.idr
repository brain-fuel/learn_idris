module Main

%default total

-- sqlite3 <db> "<sql>"

buildCmd : (db : String) -> (sql : String) -> String
buildCmd db sql = "sqlite3 " ++ db ++ " \"" ++ sql ++ "\""

main : IO ()
main = putStrLn (buildCmd "tasks.db" "INSERT INTO tasks(title) VALUES('foo');")
