module Main

%default total

-- KEY: zip headers with a row to build a JObject of JString values.

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

zipFields : List String -> List String -> List (String, JSON)
zipFields []        _         = []
zipFields _         []        = []
zipFields (h :: hs) (v :: vs) = (h, JString v) :: zipFields hs vs

rowToObject : List String -> List String -> JSON
rowToObject headers row = JObject (zipFields headers row)

main : IO ()
main = do
  let headers = ["name", "age"]
  let row = ["Ada", "36"]
  putStrLn "JSON object:"
  putStrLn (showJSON (rowToObject headers row))
