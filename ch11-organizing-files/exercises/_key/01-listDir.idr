module Main

import System.Directory

%default total

main : IO ()
main = do
  Right names <- listDir "ch11-organizing-files/exercises/fixtures/dir01"
    | Left _ => putStrLn "could not list"
  printLn names
