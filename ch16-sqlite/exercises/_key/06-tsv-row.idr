module Main

import Data.String
import Data.List1

%default total

splitRow : String -> List String
splitRow row = forget (split (== '\t') row)

main : IO ()
main = printLn (splitRow "1\tlaundry\t0")
