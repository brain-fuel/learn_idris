module Main

%default total

main : IO ()
main = do
  putStr "What is your name? "
  name <- getLine
  putStr "How old are you? "
  age <- getLine
  putStrLn ("Hi " ++ name ++ ", you are " ++ age ++ " years old.")
