module Main

%default total

-- New idea: an XML element wraps content between matching tags:
-- `<tag>body</tag>`. This is the simplest building block for XML
-- output; later exercises add attributes, prologues, and nesting.
--
-- TODO: replace `""` so `element` returns `<tag>body</tag>`.

element : (tag : String) -> (body : String) -> String
element tag body = ""

main : IO ()
main = do
  putStrLn "FIXME: build a basic XML element"
  putStrLn (element "name" "Ada")
