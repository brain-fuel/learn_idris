module Main

import Data.String
import Data.List

%default total

tableRow : List String -> String
tableRow cells = "| " ++ joinBy " | " cells ++ " |"

separator : Nat -> String
separator n = "|" ++ concat (replicate n "---|")

mkTable : (headers : List String) -> (rows : List (List String)) -> String
mkTable headers rows =
  let header = tableRow headers
      sep    = separator (length headers)
      body   = map tableRow rows
  in unlines (header :: sep :: body)

main : IO ()
main = putStr (mkTable ["name", "age"] [["Ada", "36"], ["Bob", "42"]])
