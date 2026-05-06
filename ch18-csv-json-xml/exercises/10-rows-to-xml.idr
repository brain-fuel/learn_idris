module Main

%default total

-- New idea: a complete XML document for many rows: prologue + a root
-- element wrapping all the row elements. e.g. for contacts:
--   <?xml version="1.0"?><contacts><contact>...</contact>...</contacts>
--
-- TODO: replace `""` so `rowsToXml` builds the full document.

element : String -> String -> String
element tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

childrenStr : List String -> List String -> String
childrenStr []        _         = ""
childrenStr _         []        = ""
childrenStr (h :: hs) (v :: vs) = element h v ++ childrenStr hs vs

rowToXml : (rowTag : String) -> List String -> List String -> String
rowToXml rowTag headers row = element rowTag (childrenStr headers row)

rowsToXml : (rootTag : String)
         -> (rowTag  : String)
         -> (headers : List String)
         -> (rows    : List (List String))
         -> String
rowsToXml rootTag rowTag headers rows = ""

main : IO ()
main = do
  let headers = ["name", "age"]
  let rows = [["Ada", "36"], ["Bob", "29"]]
  putStrLn "FIXME: build a full XML document"
  putStrLn (rowsToXml "contacts" "contact" headers rows)
