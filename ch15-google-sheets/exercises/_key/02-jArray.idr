module Main

import Language.JSON.Data

%default total

-- KEY for Exercise 02.

pair : JSON
pair = JArray [JString "a", JString "b"]

main : IO ()
main = putStrLn (show pair)
