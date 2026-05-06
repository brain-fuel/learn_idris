module Main

import System.File
import Data.String

%default total

covering
main : IO ()
main = do
  Right s <- readFile "ch10-files/exercises/fixtures/three-lines.txt"
    | Left _ => putStrLn "could not open file"
  let ls = lines s
  let n = sum (map (length . words) ls)
  printLn n
