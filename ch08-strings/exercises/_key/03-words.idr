module Main

import Data.String

%default total

main : IO ()
main = printLn (words "the quick brown fox")
