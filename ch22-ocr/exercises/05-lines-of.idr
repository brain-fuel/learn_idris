module Main

import Data.String

%default total

-- New idea: `Data.String.lines : String -> List String` splits a string
-- on `\n`. We use it to walk the OCR output line by line.
--
-- TODO: replace `[]` with a `lines` call so this function returns the
-- input split by newline.

linesOf : String -> List String
linesOf s = []

main : IO ()
main = do
  let sample = "alpha\nbeta\ngamma"
  let xs = linesOf sample
  putStrLn ("got " ++ show (length xs) ++ " lines")
