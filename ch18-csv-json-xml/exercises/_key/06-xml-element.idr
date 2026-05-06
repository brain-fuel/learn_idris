module Main

%default total

-- KEY: wrap body between <tag> and </tag>.

element : (tag : String) -> (body : String) -> String
element tag body = "<" ++ tag ++ ">" ++ body ++ "</" ++ tag ++ ">"

main : IO ()
main = do
  putStrLn "XML element:"
  putStrLn (element "name" "Ada")
