module Main

%default total

-- New idea: a JSON array wraps a list of JSON values. Convert a
-- `List String` to a `JArray` of `JString` values by mapping `JString`
-- across the list.
--
-- TODO: replace `JArray []` so `wrapStrings` returns a `JArray` whose
--       contents are the input strings wrapped as `JString`.

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
  showObj []              = []
  showObj ((k, v) :: rest) = (quote k ++ ":" ++ showJSON v) :: showObj rest

wrapStrings : List String -> JSON
wrapStrings xs = JArray []

main : IO ()
main = do
  putStrLn "FIXME: wrap each string as JString in a JArray"
  putStrLn (showJSON (wrapStrings ["a", "b", "c"]))
