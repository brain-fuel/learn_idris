module Main

%default total

-- Goal: change the greeting to something silly.
-- TODO: replace the word "Hello!" with anything you want.
--       Save the file (Esc, :wq) and run:  idris2 --exec main 01-change-greeting.idr

main : IO ()
main = do
  putStrLn "Hello! What is your name?"
  putStr "> "
  name <- getLine
  putStrLn ("Welcome, " ++ name ++ "!")
