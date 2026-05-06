module Main

import System.Clock

%default total

main : IO ()
main = do
  c <- clockTime UTC
  printLn (seconds c)
  printLn (nanoseconds c)
