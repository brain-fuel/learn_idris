module Main

import System.File

%default total

covering
wavSize : String -> IO Nat
wavSize path = do
  Right bytes <- readFile path
    | Left _ => pure 0
  pure (length bytes)

covering
main : IO ()
main = do
  n <- wavSize "/tmp/learn_idris_ch24_ex03.wav"
  putStrLn ("size: " ++ show n)
