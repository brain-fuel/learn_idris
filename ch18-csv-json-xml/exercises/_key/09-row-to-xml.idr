module Main

%default total

-- KEY: zip headers with row, build child elements, wrap in rowTag.

element : String -> String -> String
element tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

childrenStr : List String -> List String -> String
childrenStr []        _         = ""
childrenStr _         []        = ""
childrenStr (h :: hs) (v :: vs) = element h v ++ childrenStr hs vs

rowToXml : (rowTag : String)
        -> (headers : List String)
        -> (row : List String)
        -> String
rowToXml rowTag headers row = element rowTag (childrenStr headers row)

main : IO ()
main = do
  let headers = ["name", "age"]
  let row = ["Ada", "36"]
  putStrLn "row XML:"
  putStrLn (rowToXml "contact" headers row)
