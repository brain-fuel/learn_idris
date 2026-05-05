module Main

import System.Directory

%default total

main : IO ()
main = do
  let path = "/tmp/learn_idris_ch11_ex03"
  there <- exists path
  if there
    then putStrLn "already there"
    else do
      Right () <- createDir path
        | Left e => putStrLn (show e)
      putStrLn "created"
