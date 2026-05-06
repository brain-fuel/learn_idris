module Main

import System
import System.File
import Data.String
import Data.List
import Data.List1

%default total

imgPath : String
imgPath = "ch22-ocr/miniproject/fixtures/receipt.png"

outStem : String
outStem = "/tmp/learn_idris_ch22_receipt"

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

findTotal : List String -> Maybe String
findTotal xs = find (isInfixOf "TOTAL") xs

extractAmount : String -> Maybe Double
extractAmount line =
  let segs = forget (split (== '$') line) in
  case last' segs of
    Nothing  => Nothing
    Just raw => parseDouble (trim raw)

fmt2 : Double -> String
fmt2 d =
  let cents : Integer = cast (d * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

fmtResult : Maybe Double -> String
fmtResult Nothing  = "total: no total found"
fmtResult (Just d) = "total: $" ++ fmt2 d

covering
main : IO ()
main = do
  _ <- getLine  -- consume the "go" trigger from the test driver
  code <- System.system (mkCmd imgPath outStem)
  if code /= 0
    then putStrLn ("error: tesseract exited with code " ++ show code)
    else do
      Right txt <- readFile (outStem ++ ".txt")
        | Left e => putStrLn ("error reading OCR output: " ++ show e)
      let allLines    = lines txt
      let nonEmpty    = filter (\s => trim s /= "") allLines
      let count       = length nonEmpty
      let totalAmount = case findTotal allLines of
                          Nothing => Nothing
                          Just l  => extractAmount l
      putStrLn ("ocr'd " ++ show count ++ " lines")
      putStrLn (fmtResult totalAmount)
