module Main

import Language.JSON.Data

%default total

-- KEY for Exercise 07.

rowToJson : List String -> JSON
rowToJson row = JArray (map JString row)

buildBody : List (List String) -> JSON
buildBody rows = JObject [("values", JArray (map rowToJson rows))]

main : IO ()
main = putStrLn (show (buildBody [["a", "b", "c"]]))
