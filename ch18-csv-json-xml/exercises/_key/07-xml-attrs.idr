module Main

%default total

-- KEY: fold attrs into ` k="v"` chunks; concat between tag name and `>`.

oneAttr : (String, String) -> String
oneAttr (k, v) = " " ++ k ++ "=\"" ++ v ++ "\""

attrsString : List (String, String) -> String
attrsString []        = ""
attrsString (a :: as) = oneAttr a ++ attrsString as

elementAttrs : (tag : String)
            -> (attrs : List (String, String))
            -> (body : String)
            -> String
elementAttrs tag attrs body =
  "<" ++ tag ++ attrsString attrs ++ ">" ++ body ++ "</" ++ tag ++ ">"

main : IO ()
main = do
  putStrLn "XML element with attrs:"
  putStrLn (elementAttrs "img" [("src", "x.png"), ("alt", "x")] "")
