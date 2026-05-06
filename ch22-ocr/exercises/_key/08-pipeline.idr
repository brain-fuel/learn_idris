module Main

import System
import System.File
import Data.String
import Data.List
import Data.List1

%default total

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

covering
main : IO ()
main = do
  result <- ocrTotal "ch22-ocr/miniproject/fixtures/receipt.png"
                     "/tmp/learn_idris_ch22_ex08"
  case result of
    Just d  => putStrLn ("total: " ++ show d)
    Nothing => putStrLn "no total"
