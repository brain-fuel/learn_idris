module Main

import System

%default total

main : IO ()
main = do
  args <- getArgs
  printLn args
