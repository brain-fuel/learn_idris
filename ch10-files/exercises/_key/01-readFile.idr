module Main

import System.File

%default total

covering
main : IO ()
main = do
  Right s <- readFile "ch10-files/exercises/fixtures/hello.txt"
    | Left _ => putStrLn "could not open file"
  putStr s
