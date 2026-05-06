module Main

import Language.JSON.Data

%default total

-- Exercise 01: Importing JSON.
--
-- The contrib library `Language.JSON.Data` defines a `JSON` data type:
--
--     data JSON = JNull | JBoolean Bool | JNumber Double
--             | JString String | JArray (List JSON)
--             | JObject (List (String, JSON))
--
-- TODO: replace `JNull` with `JString "hello"` so `main` prints
--       a quoted JSON string literal.

greeting : JSON
greeting = JNull  -- FIXME: build a JString containing "hello"

main : IO ()
main = putStrLn (show greeting)
