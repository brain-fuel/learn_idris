module Main

import System.File

%default covering

main : IO ()
main = do
  result <- readFile "/no/such/path/at/all"
  case result of
    Right s  => putStr s
    Left err => putStrLn ("error: " ++ show err)
