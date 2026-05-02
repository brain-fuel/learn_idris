module Main

%default total

main : IO ()
main = do
  let age = 10
  printLn age
  let age = 100
  printLn age
