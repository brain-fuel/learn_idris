module Main

import Data.String

%default total

-- New idea: a Markdown table row is `| cell1 | cell2 | ... |`. Each
-- cell padded by one space; pipes between and at both ends.
--
-- TODO: complete `tableRow` so that
--           tableRow ["a", "b", "c"] == "| a | b | c |"
--       Hint: `"| " ++ joinBy " | " cells ++ " |"`. `joinBy` lives in
--       `Data.String` and joins a `List String` with a separator
--       string.

tableRow : List String -> String
tableRow _ = ""

main : IO ()
main = putStrLn (tableRow ["a", "b", "c"])
