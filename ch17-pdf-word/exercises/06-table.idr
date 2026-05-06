module Main

import Data.String

%default total

-- New idea: a full Markdown table is THREE pieces:
--   1) a header row     | a | b |
--   2) a separator row  |---|---|   (one `---` per column)
--   3) zero+ data rows  | x | y |
-- All glued with newlines.
--
-- TODO: complete `mkTable` so that for
--           mkTable ["name", "age"] [["Ada", "36"], ["Bob", "42"]]
--       you get
--           | name | age |
--           |---|---|
--           | Ada | 36 |
--           | Bob | 42 |
--       (each row on its own line, no trailing blank line required).
--       Hint: build the separator as `replicate (length headers) "---"`
--       then join with the same `tableRow` helper.

tableRow : List String -> String
tableRow cells = "| " ++ joinBy " | " cells ++ " |"

mkTable : (headers : List String) -> (rows : List (List String)) -> String
mkTable _ _ = ""

main : IO ()
main = putStrLn (mkTable ["name", "age"] [["Ada", "36"], ["Bob", "42"]])
