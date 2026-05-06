module Main

%default total

-- New idea: an XML document starts with a prologue declaring the
-- version: `<?xml version="1.0"?>`, then the root element.
--
-- TODO: replace `""` so `xmlDoc` prepends the prologue to the root.

xmlDoc : (root : String) -> String
xmlDoc root = ""

main : IO ()
main = do
  putStrLn "FIXME: build a full XML document with prologue"
  putStrLn (xmlDoc "<contacts></contacts>")
