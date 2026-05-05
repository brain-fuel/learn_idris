module Main

import Data.String
import Data.List1

%default total

main : IO ()
main = do
  let parts = split (== ',') "a,b,c"
  printLn (forget parts)
