module Main

import Data.String

%default total

main : IO ()
main = printLn (isInfixOf "world" "hello world")
