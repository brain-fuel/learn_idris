module Main

import Data.String

%default total

main : IO ()
main = printLn (String.length "hello world")
