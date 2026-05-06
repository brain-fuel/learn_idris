module Main

import Data.String
import Data.List1

%default total

-- Exercise 01 KEY: split a single TSV line into a list of fields.

splitOnTab : String -> List String
splitOnTab s = forget (split (== '\t') s)

main : IO ()
main = do
  let row = splitOnTab "date\tcategory\tamount"
  putStrLn (show row)
