module Main

%default total

-- New idea: every top-level name in Idris has a TYPE on its own line first,
-- then the equation. `myName : String` means "myName is a String"; the next
-- line says what String it is.
--
-- TODO: replace `FIXME` on the right of `myName =` with a String LITERAL
--       (your name in double quotes, e.g. "Johannes"). The file currently
--       fails check because the bare word `FIXME` isn't a defined name.
--       Then save and run:
--       idris2 --exec main 01-first-function.idr

myName : String
myName = "FIXME"

main : IO ()
main = putStrLn ("Hello, " ++ myName)
