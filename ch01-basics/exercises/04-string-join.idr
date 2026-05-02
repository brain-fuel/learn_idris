module Main

%default total

-- New idea: glue two strings together with `++`.
-- In Idris, `+` is for numbers; `++` is for strings (and lists -- ch06).
--
-- TODO: change "World" so the line reads "Hello, <your name>!"

main : IO ()
main = putStrLn ("Hello, " ++ "World" ++ "!")
