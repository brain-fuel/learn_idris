module Main

%default total

-- New idea: Idris does math. `+` is add, `-` subtract, `*` multiply, `div` divide.
-- `printLn` prints any value that knows how to "show" itself -- numbers do.
--
-- TODO: 1) BEFORE you run the program, predict what it will print.
--       2) Run it. Were you right?
--       3) Change the numbers, predict again, run again.

main : IO ()
main = printLn (12 + 7)
