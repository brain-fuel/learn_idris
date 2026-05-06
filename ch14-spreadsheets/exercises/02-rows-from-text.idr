module Main

import Data.String
import Data.List1

%default total

-- Exercise 02: split a whole TSV blob into rows-of-fields.
--
-- Strategy: split the text on '\n' to get raw lines, then split each
-- line on '\t' to get fields.
--
-- TODO: replace the body so the result is a 2-D list of strings.
-- For "a\tb\nc\td\n" you should get [["a","b"],["c","d"], []]
-- (the trailing empty row is fine — we'll drop it in exercise 04).

splitOnTab : String -> List String
splitOnTab s = forget (split (== '\t') s)

rowsFromText : String -> List (List String)
rowsFromText s = []

main : IO ()
main = do
  let rows = rowsFromText "a\tb\nc\td"
  putStrLn (show rows)
