module Main

import Data.String
import Data.List1
import Data.List

%default total

splitRow : String -> List String
splitRow row = forget (split (== '\t') row)

splitRows : String -> List (List String)
splitRows text =
  let lines = forget (split (== '\n') text)
      nonEmpty = filter (\l => l /= "") lines
  in map splitRow nonEmpty

main : IO ()
main = printLn (splitRows "1\tlaundry\t0\n2\tdishes\t1\n")
