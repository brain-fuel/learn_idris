module Main

import System
import System.Clock

%default total

main : IO ()
main = do
  start <- clockTime UTC
  sleep 1
  end <- clockTime UTC
  let dt = seconds end - seconds start
  printLn dt
