module Main

%default total

main : IO ()
main = do
  putStrLn "Hello! What's your name?"
  putStr "> "
  name <- getLine
  putStrLn ("Nice to meet you, " ++ name ++ ".")
