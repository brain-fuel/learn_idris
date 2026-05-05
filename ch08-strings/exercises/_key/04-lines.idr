module Main

import Data.String

%default total

main : IO ()
main = printLn (lines "a\nb\nc")
