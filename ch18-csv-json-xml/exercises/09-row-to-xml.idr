module Main

%default total

-- New idea: convert a CSV-style row plus its headers into an XML
-- element. Each `(header, value)` pair becomes a child element; the
-- whole thing is wrapped in a `<row>` (or other) element name.
--
-- TODO: replace `""` so `rowToXml` builds:
--       <row><header1>value1</header1><header2>value2</header2>...</row>

element : String -> String -> String
element tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

rowToXml : (rowTag : String)
        -> (headers : List String)
        -> (row : List String)
        -> String
rowToXml rowTag headers row = ""

main : IO ()
main = do
  let headers = ["name", "age"]
  let row = ["Ada", "36"]
  putStrLn "FIXME: build a row element with field children"
  putStrLn (rowToXml "contact" headers row)
