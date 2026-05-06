module Main

import System.File

%default total

checkOutput : String -> IO Bool
checkOutput path = exists path

main : IO ()
main = do
  here <- checkOutput "/etc/hostname"
  if here then putStrLn "present" else putStrLn "missing"
