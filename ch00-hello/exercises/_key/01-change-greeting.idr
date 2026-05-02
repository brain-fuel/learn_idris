module Main

%default total

main : IO ()
main = do
  putStrLn "Hi there! What is your name?"
  putStr "> "
  name <- getLine
  putStrLn ("Welcome, " ++ name ++ "!")
