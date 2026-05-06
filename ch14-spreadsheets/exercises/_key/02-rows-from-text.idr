module Main

import Data.String
import Data.List1

%default total

-- Exercise 02 KEY: split a whole TSV blob into rows-of-fields.

splitOnTab : String -> List String
splitOnTab s = forget (split (== '\t') s)

rowsFromText : String -> List (List String)
rowsFromText s = map splitOnTab (forget (split (== '\n') s))

main : IO ()
main = do
  let rows = rowsFromText "a\tb\nc\td"
  putStrLn (show rows)
