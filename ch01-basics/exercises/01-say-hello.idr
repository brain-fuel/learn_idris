module Main

%default total

-- New idea: `putStrLn` prints a line of text, then a newline.
-- Notice: there is no semicolon at the end -- Idris doesn't use them.
--
-- TODO: change "World" to your name, then save and run:
--       idris2 --exec main 01-say-hello.idr

main : IO ()
main = putStrLn "Hello, World!"
