module Main

import System.Directory
import Data.List

%default total

main : IO ()
main = do
  Right names <- listDir "ch11-organizing-files/exercises/fixtures/dir01"
    | Left _ => putStrLn "error"
  printLn (sort names)
