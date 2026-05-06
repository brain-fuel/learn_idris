module Main

import Language.JSON.Data

%default total

-- Exercise 07: build the request body for the Sheets values.update API.
--
-- The body looks like:
--
--     {"values": [["a","b","c"], ["d","e"]]}
--
-- — i.e. an object with one key `values`, whose value is a JSON array
-- of JSON arrays of JSON strings.
--
-- TODO: change `buildBody` so each inner row becomes a `JArray` of
--       `JString`s, and the whole thing wraps as
--       `JObject [("values", JArray rowsAsJson)]`.

buildBody : List (List String) -> JSON
buildBody rows = JNull  -- FIXME: wrap rows as {"values": [[...]]}

main : IO ()
main = putStrLn (show (buildBody [["a", "b", "c"]]))
