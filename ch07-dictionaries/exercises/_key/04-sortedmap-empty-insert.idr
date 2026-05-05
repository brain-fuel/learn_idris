module Main

import Data.SortedMap

%default total

main : IO ()
main = do
  let m1 = the (SortedMap String Int) (insert "x" 1 empty)
  let m2 = insert "y" 2 m1
  printLn (Data.SortedMap.toList m2)
