module Main

import System.File
import Data.String

%default total

covering
main : IO ()
main = do
  Right s <- readFile "ch10-files/exercises/fixtures/three-lines.txt"
    | Left _ => putStrLn "could not open file"
  let ls = filter (/= "") (lines s)
  for_ (zip [the Nat 1..length ls] ls) $ \(i, l) =>
    putStrLn (show i ++ ": " ++ l)
