module Main

import Data.SortedMap
import Data.Maybe

%default total

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2)])
  printLn (fromMaybe 0 (lookup "z" m))
