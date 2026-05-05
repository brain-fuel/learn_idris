module Main

%default total

main : IO ()
main = do
  let doubled = 21 * 2
  printLn doubled
  putStrLn "done"
