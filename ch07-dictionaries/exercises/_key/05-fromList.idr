module Main

import Data.SortedMap

%default total

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2), ("c", 3)])
  printLn (Data.SortedMap.toList m)
