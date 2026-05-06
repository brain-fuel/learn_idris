module Main

import System
import System.File
import Data.String

%default total

-- Invoice generator starter file.
--
-- Behavior: read `ch17-pdf-word/miniproject/fixtures/items.tsv` (rows
-- of `quantity<TAB>desc<TAB>unit_price`), generate a Markdown invoice
-- at `/tmp/learn_idris_ch17_invoice.md`, then shell out to
--     pandoc /tmp/learn_idris_ch17_invoice.md -o /tmp/learn_idris_ch17_invoice.pdf
-- On success, print exactly:
--     wrote /tmp/learn_idris_ch17_invoice.pdf
--
-- The test driver only checks for that one substring on stdout, so
-- this stub deliberately prints `wrote FIXME` (no actual pandoc call).
-- That makes `make verify-ch17` fail until you wire it up — exactly
-- the red-then-green gradient we want.
--
-- TODO 1: read the TSV fixture from `tsvPath` (`readFile`).
-- TODO 2: parse each non-empty row into (qty : Int, desc : String,
--         unit : Double) — see ch14 spreadsheet exercises for the TSV
--         pattern (`split (== '\t')` then `forget`).
-- TODO 3: build a Markdown document: an `# Invoice` heading, a table
--         (qty | desc | unit_price | line_total), and a `Total: $XX.XX`
--         line at the bottom.
-- TODO 4: `writeFile mdPath document` — mark the function `covering`.
-- TODO 5: `code <- System.system ("pandoc " ++ mdPath ++ " -o " ++ pdfPath)`.
-- TODO 6: if `code == 0` and `exists pdfPath`, print
--           "wrote " ++ pdfPath
--         else print an error.

tsvPath : String
tsvPath = "ch17-pdf-word/miniproject/fixtures/items.tsv"

mdPath : String
mdPath = "/tmp/learn_idris_ch17_invoice.md"

pdfPath : String
pdfPath = "/tmp/learn_idris_ch17_invoice.pdf"

main : IO ()
main = do
  _ <- getLine  -- consume the "go" trigger from the test driver
  putStrLn "wrote FIXME"
