module Main

import System.Clock

%default total

getSeconds : IO Integer
getSeconds = do
  c <- clockTime UTC
  pure (seconds c)

main : IO ()
main = do
  s <- getSeconds
  printLn s
