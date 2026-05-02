module Main

%default total

main : IO ()
main = do
  putStrLn "What is your name?"
  putStr "> "
  name <- getLine
  putStrLn ("Hi, " ++ name ++ ".")
  putStrLn ("Your name has cool letters in it, " ++ name ++ ".")
