module Main

%default total

main : IO ()
main = do
  putStr "say yes: "
  answer <- getLine
  if answer == "yes" then putStrLn "hello!" else putStrLn "goodbye"
