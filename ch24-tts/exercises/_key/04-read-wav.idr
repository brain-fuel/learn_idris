module Main

import System.File

%default total

covering
readWav : String -> IO (Either FileError String)
readWav path = readFile path

covering
main : IO ()
main = do
  result <- readWav "/tmp/learn_idris_ch24_ex03.wav"
  case result of
    Left err  => putStrLn ("error: " ++ show err)
    Right txt => putStrLn ("read " ++ show (length txt) ++ " bytes")
