module Main

%default total

-- KEY: prepend the XML prologue to the root element.

xmlDoc : (root : String) -> String
xmlDoc root = "<?xml version=\"1.0\"?>" ++ root

main : IO ()
main = do
  putStrLn "XML document:"
  putStrLn (xmlDoc "<contacts></contacts>")
