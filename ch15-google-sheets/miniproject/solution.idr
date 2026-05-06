module Main

import Data.String
import Data.List1

%default total

-- Miniproject: gsheet-append --dry-run
--
-- Read one stdin line of the form
--
--     <spreadsheet-id> <sheet-name> <a,b,c>
--
-- (three space-separated tokens; the third is a comma-separated row).
--
-- Print three lines:
--
--     PUT https://sheets.googleapis.com/v4/spreadsheets/<id>/values/<sheet>!A1?valueInputOption=USER_ENTERED
--     Authorization: Bearer FAKE_TOKEN
--     Body: {"values":[["a","b","c"]]}
--
-- The stub below prints FIXME for every line so the chapter's red
-- gradient kicks in. Use the ideas from exercises 05-09 to fill it
-- in. (Define helpers inline here — the chapter's exercises and the
-- miniproject do not import each other.)
--
-- TODO:
--   1. parse the stdin line into (id, sheetName, csv).
--   2. build the URL, the Authorization header, and the JSON body.
--   3. print the three lines.

main : IO ()
main = do
  _ <- getLine
  putStrLn "PUT FIXME"
  putStrLn "Authorization: FIXME"
  putStrLn "Body: FIXME"
