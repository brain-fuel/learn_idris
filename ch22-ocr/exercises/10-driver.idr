module Main

import System
import System.File
import Data.String
import Data.List
import Data.List1

%default total

-- New idea: top-to-bottom driver. Read one line from stdin (the path
-- to the image), OCR it, parse the total, print the formatted result.
--
-- TODO: replace the `pure ()` placeholder with a real wiring that:
--   1. reads the image path with `getLine`
--   2. calls `ocrTotal img "/tmp/learn_idris_ch22_ex10"`
--   3. prints `fmtResult` of the answer

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
ocrTotal img out = do
  result <- ocr img out
  case result of
    Left _    => pure Nothing
    Right txt =>
      case findTotal (lines txt) of
        Nothing => pure Nothing
        Just l  => pure (extractAmount l)

fmt2 : Double -> String
fmt2 d =
  let cents : Integer = cast (d * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

fmtResult : Maybe Double -> String
fmtResult Nothing  = "no total found"
fmtResult (Just d) = "total: $" ++ fmt2 d

covering
main : IO ()
main = putStrLn "FIXME"
