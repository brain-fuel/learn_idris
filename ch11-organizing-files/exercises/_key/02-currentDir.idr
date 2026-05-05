module Main

import System.Directory

%default total

main : IO ()
main = do
  mcwd <- currentDir
  case mcwd of
    Just d  => putStrLn d
    Nothing => putStrLn "(unknown)"
