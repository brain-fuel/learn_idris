module Main

import System

%default total

main : IO ()
main = do
  code <- System.system "date +%s"
  putStrLn ("date exit: " ++ show code)
