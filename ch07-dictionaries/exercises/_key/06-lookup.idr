module Main

import Data.SortedMap

%default total

main : IO ()
main = do
  let m = the (SortedMap String Int) (fromList [("a", 1), ("b", 2)])
  case lookup "a" m of
    Just v  => printLn v
    Nothing => putStrLn "missing"
