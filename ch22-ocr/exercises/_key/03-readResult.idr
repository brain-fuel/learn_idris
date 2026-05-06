module Main

import System.File

%default total

covering
readOcr : (out : String) -> IO String
readOcr out = do
  Right txt <- readFile (out ++ ".txt")
    | Left _ => pure ""
  pure txt

covering
main : IO ()
main = do
  txt <- readOcr "/tmp/learn_idris_ch22_ex03"
  putStrLn ("read " ++ show (length txt) ++ " chars")
