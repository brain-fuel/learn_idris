module Main

import Data.String
import Data.List1

%default total

-- KEY: split a single CSV row on commas.

splitRow : String -> List String
splitRow s = forget (split (== ',') s)

main : IO ()
main = do
  let row = "Ada,ada@example.com,36"
  putStrLn "fields:"
  printLn (splitRow row)
