module Main

import Data.String
import Data.List1

%default total

-- KEY for the gsheet-append --dry-run miniproject.
--
-- Reads one stdin line "<id> <sheet> <a,b,c>" and prints the would-be
-- PUT request: URL, Authorization header, and JSON body. No socket;
-- just a printed dry-run.
--
-- We hand-roll the small slice of JSON serialization we need (matches
-- chapter 18's approach). The exercises walk through `Language.JSON.Data`
-- separately; here we just want a runnable dry-run.

-- Exercise 09: assemble the Sheets v4 PUT URL.
buildUrl : (id : String) -> (range : String) -> String
buildUrl id range =
  "https://sheets.googleapis.com/v4/spreadsheets/" ++ id ++ "/values/" ++ range

-- Exercise 05: A1-notation range. Hard-coded to A1 for the dry-run.
cellRange : (sheet : String) -> (tl : String) -> String
cellRange sheet tl = sheet ++ "!" ++ tl

-- Exercise 06: query string fragment.
valueInputOption : String
valueInputOption = "?valueInputOption=USER_ENTERED"

-- Exercise 08: Authorization header.
bearerHeader : (token : String) -> (String, String)
bearerHeader token = ("Authorization", "Bearer " ++ token)

-- Tiny JSON-string serializer. We don't escape special characters; the
-- dry-run inputs are plain ASCII tokens from a CSV cell.
quote : String -> String
quote s = "\"" ++ s ++ "\""

joinComma : List String -> String
joinComma []        = ""
joinComma [s]       = s
joinComma (s :: ss) = s ++ "," ++ joinComma ss

-- Exercise 07: wrap a list of rows as `{"values":[[...]]}` JSON.
rowToJson : List String -> String
rowToJson row = "[" ++ joinComma (map quote row) ++ "]"

buildBody : List (List String) -> String
buildBody rows =
  "{\"values\":[" ++ joinComma (map rowToJson rows) ++ "]}"

splitOn : Char -> String -> List String
splitOn c s = forget (split (== c) s)

main : IO ()
main = do
  line <- getLine
  case words line of
    (id :: sheet :: csv :: _) => do
      let row    = splitOn ',' csv
      let url    = buildUrl id (cellRange sheet "A1") ++ valueInputOption
      let (k, v) = bearerHeader "FAKE_TOKEN"
      putStrLn ("PUT " ++ url)
      putStrLn (k ++ ": " ++ v)
      putStrLn ("Body: " ++ buildBody [row])
    _ => putStrLn "error: expected `<id> <sheet> <a,b,c>` on stdin"
