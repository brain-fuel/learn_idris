module Main

import System

%default total

main : IO ()
main = do
  putStrLn "going"
  exitWith (ExitFailure 7)
