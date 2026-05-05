module Main

import Data.String

%default total

main : IO ()
main = putStrLn (toUpper "hello")
