module Main

import System
import System.File
import Data.String

%default total

-- Receipt scanner starter file.
--
-- Behavior: read the receipt image at `imgPath`, shell out to
-- tesseract to OCR it, parse the resulting text for the line
-- containing `"TOTAL"`, extract the dollar amount, and print:
--
--     ocr'd <N> lines
--     total: $XX.XX
--
-- where N is the count of non-empty OCR'd lines.
--
-- The test driver greps for `total: $42.99`, so this stub deliberately
-- prints `total: $FIXME` (no actual tesseract call). That makes
-- `make verify-ch22` fail until you wire it up — the red-then-green
-- gradient we want.
--
-- TODO 1: build a `tesseract <imgPath> <outStem> -l eng 2>/dev/null`
--         command and run it via `System.system` (qualified to dodge
--         `System.Escaped.system`).
-- TODO 2: on non-zero exit, print an error.
-- TODO 3: on success, `readFile (outStem ++ ".txt")` and split via
--         `lines`. Filter out empty lines for the count.
-- TODO 4: find the line containing `"TOTAL"` (use `isInfixOf`), split
--         on `'$'`, take the last segment, `parseDouble` it.
-- TODO 5: print exactly two lines:
--             "ocr'd " ++ show <count> ++ " lines"
--             "total: $" ++ fmt2 <amount>

imgPath : String
imgPath = "ch22-ocr/miniproject/fixtures/receipt.png"

outStem : String
outStem = "/tmp/learn_idris_ch22_receipt"

covering
main : IO ()
main = do
  _ <- getLine  -- consume the "go" trigger from the test driver
  putStrLn "ocr'd 0 lines"
  putStrLn "total: $FIXME"
