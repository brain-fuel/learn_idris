module Main

import Data.List

%default total

main : IO ()
main = printLn (sort (the (List Int) [3, 1, 4, 1, 5, 9, 2, 6]))
