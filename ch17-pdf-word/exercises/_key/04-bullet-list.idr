module Main

import Data.String

%default total

mkItem : String -> String
mkItem s = "- " ++ s

bulletList : List String -> String
bulletList xs = unlines (map mkItem xs)

main : IO ()
main = putStr (bulletList ["milk", "eggs", "bread"])
