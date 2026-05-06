module Main

import Language.JSON.Data

%default total

-- Exercise 03: a JSON object.
--
-- `JObject` takes a `List (String, JSON)` — a list of (key, value) pairs.
--
-- TODO: build an object with one entry `("key", JString "v")`.
--       Expected output: {"key":"v"}

obj : JSON
obj = JObject []  -- FIXME: add a single ("key", JString "v") entry

main : IO ()
main = putStrLn (show obj)
