module Main

%default total

-- New idea: build a SQL INSERT statement as a plain String. The CLI
-- will execute it. Keep the format predictable; we will quote-escape
-- the title separately (see exercise 01).
--
-- Target shape:  INSERT INTO tasks(title) VALUES('foo');
--
-- TODO: return that exact string, with `title` substituted in.

buildInsert : (title : String) -> String
buildInsert title = "FIXME"

main : IO ()
main = putStrLn (buildInsert "foo")
