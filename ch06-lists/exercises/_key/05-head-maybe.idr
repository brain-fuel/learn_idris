module Main

import Data.List

%default total

main : IO ()
main = case head' (the (List Int) []) of
         Just x  => printLn x
         Nothing => putStrLn "empty list"
