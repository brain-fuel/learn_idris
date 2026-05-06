module Main

import Data.String

%default total

-- New idea: JSON values are a small algebraic data type. Idris 2's
-- contrib library provides `Language.JSON.Data.JSON` with this shape:
--
--   data JSON = JNull | JBoolean Bool | JNumber Double | JString String
--             | JArray (List JSON) | JObject (List (String, JSON))
--
-- For chapter 18 we hand-roll the same ADT locally so every exercise
-- typechecks against `base` only. The shape and serialization match the
-- contrib module — substitute the import in your own code.
--
-- TODO: replace `""` so `showStringJ` returns the proper JSON encoding
--       of `JString "x"` (a quoted, escaped string: `"x"`).

data JSON
  = JNull
  | JBoolean Bool
  | JNumber Double
  | JString String
  | JArray (List JSON)
  | JObject (List (String, JSON))

quote : String -> String
quote s = "\"" ++ s ++ "\""

showStringJ : String -> String
showStringJ s = ""

main : IO ()
main = do
  putStrLn "FIXME: JSON-encode the string"
  putStrLn (showStringJ "x")
