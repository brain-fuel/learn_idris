module Main

%default total

-- INSERT INTO tasks(title) VALUES('foo');

buildInsert : (title : String) -> String
buildInsert title =
  "INSERT INTO tasks(title) VALUES('" ++ title ++ "');"

main : IO ()
main = putStrLn (buildInsert "foo")
