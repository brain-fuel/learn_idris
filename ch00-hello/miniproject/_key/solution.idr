module Main

%default total

main : IO ()
main = do
  putStrLn "What's the recipient's name?"
  putStr "> "
  name <- getLine
  putStrLn "How old are they?"
  putStr "> "
  age <- getLine
  putStrLn ("Happy birthday, " ++ name ++ "!")
  putStrLn ("You're " ++ age ++ " today — have a great year!")
