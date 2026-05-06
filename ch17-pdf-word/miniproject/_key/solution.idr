module Main

import System
import System.File
import Data.String
import Data.List
import Data.List1

%default total

tsvPath : String
tsvPath = "ch17-pdf-word/miniproject/fixtures/items.tsv"

mdPath : String
mdPath = "/tmp/learn_idris_ch17_invoice.md"

pdfPath : String
pdfPath = "/tmp/learn_idris_ch17_invoice.pdf"

record Item where
  constructor MkItem
  qty       : Integer
  desc      : String
  unitPrice : Double

lineTotal : Item -> Double
lineTotal it = cast it.qty * it.unitPrice

-- Two-decimal formatting for dollars (no padding for cents needed by
-- the driver — it greps for the wrote-line, not the table contents).
fmt2 : Double -> String
fmt2 d =
  let cents : Integer = cast (d * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

parseRow : String -> Maybe Item
parseRow line =
  case forget (split (== '\t') line) of
    [q, d, u] =>
      case (parseInteger q, parseDouble u) of
        (Just qi, Just ud) => Just (MkItem qi d ud)
        _                  => Nothing
    _ => Nothing

parseRows : String -> List Item
parseRows contents =
  let rawLines = lines contents
      nonEmpty = filter (\s => s /= "") rawLines
  in mapMaybe parseRow nonEmpty

mkRow : Item -> String
mkRow it =
  "| " ++ show it.qty
       ++ " | " ++ it.desc
       ++ " | $" ++ fmt2 it.unitPrice
       ++ " | $" ++ fmt2 (lineTotal it)
       ++ " |"

mkHeader : String
mkHeader = "| qty | desc | unit | line total |"

mkSep : String
mkSep = "|---|---|---|---|"

buildDoc : List Item -> String
buildDoc items =
  let grandTotal = sum (map lineTotal items)
      header     = "# Invoice"
      tableRows  = mkHeader :: mkSep :: map mkRow items
      table      = unlines tableRows
      totalLine  = "Total: $" ++ fmt2 grandTotal
  in joinBy "\n\n" [header, table, totalLine] ++ "\n"

covering
writeMd : String -> IO (Either FileError ())
writeMd content = writeFile mdPath content

covering
main : IO ()
main = do
  _ <- getLine  -- consume the "go" trigger
  Right contents <- readFile tsvPath
    | Left err => putStrLn ("error reading " ++ tsvPath ++ ": " ++ show err)
  let items = parseRows contents
  let doc   = buildDoc items
  Right () <- writeMd doc
    | Left err => putStrLn ("error writing " ++ mdPath ++ ": " ++ show err)
  code <- System.system ("pandoc " ++ mdPath ++ " -o " ++ pdfPath)
  if code /= 0
    then putStrLn ("error: pandoc exited with code " ++ show code)
    else do
      ok <- exists pdfPath
      if ok
        then putStrLn ("wrote " ++ pdfPath)
        else putStrLn ("error: " ++ pdfPath ++ " was not created")
