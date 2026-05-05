module Main

import Data.String

%default total

main : IO ()
main = putStrLn (substr 6 5 "hello world")
