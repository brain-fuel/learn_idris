module Main

import System.File
import Data.String

%default covering

readLines : String -> IO (List String)
readLines path = do
  result <- readFile path
  case result of
    Right contents => pure (filter (/= "") (lines contents))
    Left _         => pure []

main : IO ()
main = do
  xs <- readLines "ch10-files/exercises/fixtures/three-lines.txt"
  printLn xs
