module Main

import Data.String
import Data.List1
import Data.List

%default total

-- New idea: a result set is multiple rows separated by newlines.
-- Split the whole text on `'\n'`, drop any trailing empty row, then
-- split each line on `'\t'`.
--
-- TODO: parse `text` into `List (List String)`. Drop empty lines so
--       that a trailing newline does not produce a phantom row.

splitRow : String -> List String
splitRow row = forget (split (== '\t') row)

splitRows : String -> List (List String)
splitRows text = []

main : IO ()
main = printLn (splitRows "1\tlaundry\t0\n2\tdishes\t1\n")
