module Main

import Data.String
import Data.List1
import System.File

%default total

------------------------------------------------------------
-- JSON ADT (mirrors contrib `Language.JSON.Data` shape).

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

------------------------------------------------------------
-- CSV parsing (split on commas; rows split on newlines).

splitFields : String -> List String
splitFields s = forget (split (== ',') s)

splitLines : String -> List String
splitLines s = forget (split (== '\n') s)

dropEmpty : List String -> List String
dropEmpty []        = []
dropEmpty (x :: xs) = if x == "" then dropEmpty xs else x :: dropEmpty xs

parseCsv : String -> (List String, List (List String))
parseCsv text =
  case dropEmpty (splitLines text) of
    []          => ([], [])
    (h :: rest) => (splitFields h, map splitFields rest)

------------------------------------------------------------
-- Row -> JSON object.

zipFields : List String -> List String -> List (String, JSON)
zipFields []        _         = []
zipFields _         []        = []
zipFields (h :: hs) (v :: vs) = (h, JString v) :: zipFields hs vs

rowsToJson : List String -> List (List String) -> JSON
rowsToJson headers rows =
  JArray (map (\r => JObject (zipFields headers r)) rows)

------------------------------------------------------------
-- Row -> XML.

xmlElement : String -> String -> String
xmlElement tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

childrenStr : List String -> List String -> String
childrenStr []        _         = ""
childrenStr _         []        = ""
childrenStr (h :: hs) (v :: vs) = xmlElement h v ++ childrenStr hs vs

rowsBody : List String -> List (List String) -> String
rowsBody _       []          = ""
rowsBody headers (r :: rest) =
  xmlElement "contact" (childrenStr headers r) ++ rowsBody headers rest

rowsToXml : List String -> List (List String) -> String
rowsToXml headers rows =
  "<?xml version=\"1.0\"?>" ++ xmlElement "contacts" (rowsBody headers rows)

------------------------------------------------------------
-- IO.

csvPath : String
csvPath = "ch18-csv-json-xml/miniproject/fixtures/contacts.csv"

covering
main : IO ()
main = do
  _ <- getLine
  Right text <- readFile csvPath
    | Left err => putStrLn ("error reading " ++ csvPath ++ ": " ++ show err)
  let (headers, rows) = parseCsv text
  putStrLn "=== JSON ==="
  putStrLn (showJSON (rowsToJson headers rows))
  putStrLn "=== XML ==="
  putStrLn (rowsToXml headers rows)
