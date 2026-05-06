module Main

import System.File
import Data.String

%default total

covering
main : IO ()
main = do
  Right s <- readFile "ch10-files/exercises/fixtures/three-lines.txt"
    | Left err => putStrLn ("error: " ++ show err)
  let ls = filter (/= "") (lines s)
  let nLines = length ls
  let nWords = sum (map (length . words) ls)
  let summary = "lines=" ++ show nLines ++ " words=" ++ show nWords
  Right () <- writeFile "/tmp/learn_idris_ch10_recap.txt" (summary ++ "\n")
    | Left err => putStrLn ("error: " ++ show err)
  putStrLn summary
