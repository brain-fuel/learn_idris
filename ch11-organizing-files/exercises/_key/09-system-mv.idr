module Main

import System

%default total

main : IO ()
main = do
  code <- System.system "mv /tmp/learn_idris_ch11_ex09/from.txt /tmp/learn_idris_ch11_ex09/to.txt"
  if code == 0 then putStrLn "moved" else putStrLn "error"
