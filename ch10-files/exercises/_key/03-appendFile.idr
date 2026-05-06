module Main

import System.File

%default total

path : String
path = "/tmp/learn_idris_ch10_ex03.txt"

covering
main : IO ()
main = do
  Right () <- writeFile path ""
    | Left err => putStrLn ("error: " ++ show err)
  Right () <- appendFile path "line A\n"
    | Left err => putStrLn ("error: " ++ show err)
  Right () <- appendFile path "line B\n"
    | Left err => putStrLn ("error: " ++ show err)
  Right s <- readFile path
    | Left err => putStrLn ("error: " ++ show err)
  putStr s
