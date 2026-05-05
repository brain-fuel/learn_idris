module Main

import System.File

%default total

main : IO ()
main = if !(exists "/etc/hostname")
         then putStrLn "found"
         else putStrLn "missing"
