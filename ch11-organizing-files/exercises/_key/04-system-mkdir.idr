module Main

import System

%default total

main : IO ()
main = do
  code <- System.system "mkdir -p /tmp/learn_idris_ch11_ex04/sub/sub"
  printLn code
  if code == 0 then putStrLn "ok" else putStrLn "not ok"
