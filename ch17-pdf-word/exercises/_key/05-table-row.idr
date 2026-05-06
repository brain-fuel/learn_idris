module Main

import Data.String

%default total

tableRow : List String -> String
tableRow cells = "| " ++ joinBy " | " cells ++ " |"

main : IO ()
main = putStrLn (tableRow ["a", "b", "c"])
