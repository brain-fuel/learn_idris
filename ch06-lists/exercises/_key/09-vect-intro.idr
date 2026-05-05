module Main

import Data.Vect

%default total

four : Vect 4 Int
four = [10, 20, 30, 40]

main : IO ()
main = printLn four
