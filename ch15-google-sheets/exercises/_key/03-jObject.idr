module Main

import Language.JSON.Data

%default total

-- KEY for Exercise 03.

obj : JSON
obj = JObject [("key", JString "v")]

main : IO ()
main = putStrLn (show obj)
