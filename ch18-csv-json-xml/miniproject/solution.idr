module Main

import Data.String
import Data.List1
import System.File

%default total

-- multi-convert: read miniproject/fixtures/contacts.csv, emit JSON
-- and XML serializations of the same data, separated by markers:
--
--   === JSON ===
--   [{"name":"Ada","email":"ada@example.com","age":"36"}, ...]
--   === XML ===
--   <?xml version="1.0"?><contacts><contact><name>Ada</name>...
--
-- TODO: replace the FIXMEs in main so that:
--   1. read `ch18-csv-json-xml/miniproject/fixtures/contacts.csv`
--   2. parse the header row + data rows (CSV split on commas)
--   3. print `=== JSON ===` then the JSON array of objects
--   4. print `=== XML ===` then the full XML document
--
-- The exercises 01-10 build all the helpers you need.

csvPath : String
csvPath = "ch18-csv-json-xml/miniproject/fixtures/contacts.csv"

covering
main : IO ()
main = do
  _ <- getLine
  putStrLn "FIXME: emit JSON and XML"
