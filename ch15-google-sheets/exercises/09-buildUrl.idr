module Main

%default total

-- Exercise 09: build a Sheets v4 PUT URL.
--
-- The shape is:
--
--     https://sheets.googleapis.com/v4/spreadsheets/<id>/values/<range>
--
-- TODO: change `buildUrl` so it returns the URL above with `id` and
--       `range` interpolated. With the call below, expect
--       `https://sheets.googleapis.com/v4/spreadsheets/1abc/values/Sheet1!A1`.

buildUrl : (id : String) -> (range : String) -> String
buildUrl id range = "FIXME"  -- TODO: assemble the full Sheets v4 URL

main : IO ()
main = putStrLn (buildUrl "1abc" "Sheet1!A1")
