module Main

%default total

-- New idea: XML attributes go inside the opening tag as `key="value"`
-- pairs separated by spaces: `<tag k="v" k2="v2">body</tag>`.
-- Fold the attribute list into a single space-prefixed string.
--
-- TODO: replace `""` so `elementAttrs` builds the full opening tag with
--       attributes, the body, and the closing tag.

elementAttrs : (tag : String)
            -> (attrs : List (String, String))
            -> (body : String)
            -> String
elementAttrs tag attrs body = ""

main : IO ()
main = do
  putStrLn "FIXME: build an XML element with attributes"
  putStrLn (elementAttrs "img" [("src", "x.png"), ("alt", "x")] "")
