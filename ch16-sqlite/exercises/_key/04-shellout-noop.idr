module Main

import System

%default total

-- Run `true`; print 0.

main : IO ()
main = do
  code <- System.system "true"
  printLn code
