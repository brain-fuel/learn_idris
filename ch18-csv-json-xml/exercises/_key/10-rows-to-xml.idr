module Main

%default total

-- KEY: prologue + rootTag wrapping all rowTag children.

element : String -> String -> String
element tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

childrenStr : List String -> List String -> String
childrenStr []        _         = ""
childrenStr _         []        = ""
childrenStr (h :: hs) (v :: vs) = element h v ++ childrenStr hs vs

rowToXml : (rowTag : String) -> List String -> List String -> String
rowToXml rowTag headers row = element rowTag (childrenStr headers row)

rowsBody : String -> List String -> List (List String) -> String
rowsBody _      _       []          = ""
rowsBody rowTag headers (r :: rest) = rowToXml rowTag headers r ++ rowsBody rowTag headers rest

rowsToXml : (rootTag : String)
         -> (rowTag  : String)
         -> (headers : List String)
         -> (rows    : List (List String))
         -> String
rowsToXml rootTag rowTag headers rows =
  "<?xml version=\"1.0\"?>" ++ element rootTag (rowsBody rowTag headers rows)

main : IO ()
main = do
  let headers = ["name", "age"]
  let rows = [["Ada", "36"], ["Bob", "29"]]
  putStrLn "rows XML:"
  putStrLn (rowsToXml "contacts" "contact" headers rows)
