module Main

%default total

main : IO ()
main = do
  putStr "What is your age? "
  answer <- getLine
  putStrLn ("You said: " ++ answer)
