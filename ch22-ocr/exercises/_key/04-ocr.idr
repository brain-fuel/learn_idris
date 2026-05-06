module Main

import System
import System.File

%default total

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

covering
ocr : (img : String) -> (out : String) -> IO (Either String String)
ocr img out = do
  code <- System.system (mkCmd img out)
  if code /= 0
    then pure (Left ("tesseract failed on " ++ img))
    else do
      Right txt <- readFile (out ++ ".txt")
        | Left e => pure (Left (show e))
      pure (Right txt)

covering
main : IO ()
main = do
  result <- ocr "ch22-ocr/miniproject/fixtures/receipt.png"
                "/tmp/learn_idris_ch22_ex04"
  case result of
    Left e  => putStrLn ("error: " ++ e)
    Right t => putStrLn t
