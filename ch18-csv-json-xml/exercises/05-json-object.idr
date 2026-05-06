module Main

%default total

-- New idea: a JSON object pairs string keys with JSON values. To
-- convert a CSV row plus a header row into a `JObject`, zip them and
-- wrap each value as a `JString`.
--
-- TODO: replace `JObject []` so `rowToObject` zips the headers with the
--       row, wrapping each value as `JString`.

data JSON
  = JNull
  | JBoolean Bool
  | JNumber Double
  | JString String
  | JArray (List JSON)
  | JObject (List (String, JSON))

quote : String -> String
quote s = "\"" ++ s ++ "\""

jjoin : String -> List String -> String
jjoin _   []        = ""
jjoin _   [s]       = s
jjoin sep (s :: ss) = s ++ sep ++ jjoin sep ss

mutual
  showJSON : JSON -> String
  showJSON JNull        = "null"
  showJSON (JBoolean b) = if b then "true" else "false"
  showJSON (JNumber n)  = show n
  showJSON (JString s)  = quote s
  showJSON (JArray xs)  = "[" ++ jjoin "," (showArr xs) ++ "]"
  showJSON (JObject ps) = "{" ++ jjoin "," (showObj ps) ++ "}"

  showArr : List JSON -> List String
  showArr []        = []
  showArr (x :: xs) = showJSON x :: showArr xs

  showObj : List (String, JSON) -> List String
  showObj []               = []
  showObj ((k, v) :: rest) = (quote k ++ ":" ++ showJSON v) :: showObj rest

rowToObject : List String -> List String -> JSON
rowToObject headers row = JObject []

main : IO ()
main = do
  let headers = ["name", "age"]
  let row = ["Ada", "36"]
  putStrLn "FIXME: zip headers with row and wrap as JObject"
  putStrLn (showJSON (rowToObject headers row))
