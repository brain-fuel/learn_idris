module Main

import System
import System.File

%default total

tmpPath : String
tmpPath = "/tmp/learn_idris_ch16_ex05.txt"

covering
readback : IO ()
readback = do
  _ <- System.system ("echo hello > " ++ tmpPath)
  Right contents <- readFile tmpPath
    | Left e => putStrLn ("error: " ++ show e)
  putStr contents

covering
main : IO ()
main = readback
