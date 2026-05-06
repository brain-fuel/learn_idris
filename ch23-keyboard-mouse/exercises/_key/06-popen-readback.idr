module Main

import System
import System.File

%default total

covering
readXdotool : String -> IO String
readXdotool cmd = do
  _ <- System.system (cmd ++ " > /tmp/learn_idris_ch23_tmp.txt")
  Right s <- readFile "/tmp/learn_idris_ch23_tmp.txt"
    | Left _ => pure ""
  pure s

covering
main : IO ()
main = do
  s <- readXdotool "xdotool getmouselocation"
  putStrLn ("readXdotool got: " ++ s)
