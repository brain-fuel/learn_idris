module Main

import System

%default total

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

covering
ocrRun : (img : String) -> (out : String) -> IO Int
ocrRun img out = System.system (mkCmd img out)

covering
main : IO ()
main = do
  code <- ocrRun "ch22-ocr/miniproject/fixtures/receipt.png"
                 "/tmp/learn_idris_ch22_ex02"
  putStrLn ("exit: " ++ show code)
