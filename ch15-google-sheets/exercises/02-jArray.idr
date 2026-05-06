module Main

import Language.JSON.Data

%default total

-- Exercise 02: a JSON array.
--
-- `JArray` wraps a `List JSON`. Each element is itself a `JSON` value.
--
-- TODO: replace the empty list with a two-element list containing
--       `JString "a"` and `JString "b"`. The expected output is `["a","b"]`.

pair : JSON
pair = JArray []  -- FIXME: build a 2-element JArray of JStrings

main : IO ()
main = putStrLn (show pair)
