module Main

import System
import System.File
import Data.String
import Data.List
import Data.List1

%default total

-- New idea: chain everything we've built — OCR an image, split into
-- lines, look for the TOTAL line, extract the dollar amount.
--
-- TODO: replace `pure Nothing` with a do-block that:
--   1. calls `ocr img out`
--   2. on Right contents, splits via `lines`, finds the TOTAL line,
--      then `extractAmount`s the result
--   3. returns `Nothing` on failure paths

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

covering
ocr : (img : String) -> (out : String) -> IO (Either String String)
ocr img out = do
  code <- System.system (mkCmd img out)
  if code /= 0
    then pure (Left "tesseract failed")
    else do
      Right txt <- readFile (out ++ ".txt")
        | Left e => pure (Left (show e))
      pure (Right txt)

findTotal : List String -> Maybe String
findTotal xs = find (isInfixOf "TOTAL") xs

extractAmount : String -> Maybe Double
extractAmount line =
  let segs = forget (split (== '$') line) in
  case last' segs of
    Nothing  => Nothing
    Just raw => parseDouble (trim raw)

covering
ocrTotal : (img : String) -> (out : String) -> IO (Maybe Double)
ocrTotal img out = pure Nothing

main : IO ()
main = do
  result <- ocrTotal "receipt.png" "/tmp/learn_idris_ch22_ex08"
  case result of
    Just d  => putStrLn ("total: " ++ show d)
    Nothing => putStrLn "no total"
