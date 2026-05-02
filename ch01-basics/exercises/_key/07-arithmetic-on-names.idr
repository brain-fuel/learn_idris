module Main

%default total

main : IO ()
main = do
  let a = 6
  let b = 4
  printLn (a + b)
  printLn (a * b)
