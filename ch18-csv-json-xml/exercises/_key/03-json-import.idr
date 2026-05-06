module Main

import Data.String

%default total

-- KEY: JSON-encode a string by wrapping it in double quotes.

data JSON
  = JNull
  | JBoolean Bool
  | JNumber Double
  | JString String
  | JArray (List JSON)
  | JObject (List (String, JSON))

quote : String -> String
quote s = "\"" ++ s ++ "\""

showStringJ : String -> String
showStringJ s = quote s

main : IO ()
main = do
  putStrLn "JSON string encoding:"
  putStrLn (showStringJ "x")
