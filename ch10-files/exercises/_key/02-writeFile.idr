module Main

import System.File

%default total

main : IO ()
main = do
  Right () <- writeFile "/tmp/learn_idris_ch10_ex02.txt" "saved!"
    | Left err => putStrLn ("error: " ++ show err)
  putStrLn "wrote it"
