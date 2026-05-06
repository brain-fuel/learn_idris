module Main

import System
import System.File

%default total

-- New idea: glue `ocrRun` and `readOcr` into a single high-level call.
-- If tesseract exits non-zero we fail with `Left "<reason>"`; otherwise
-- we read the `.txt` file and return `Right contents`.
--
-- TODO: chain the two pieces. Replace the placeholder with code that:
--   1. builds the command and runs it via `System.system`
--   2. branches on the exit code: non-zero -> `Left`
--   3. reads `out ++ ".txt"` and returns `Right`

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

covering
ocr : (img : String) -> (out : String) -> IO (Either String String)
ocr img out = pure (Left "FIXME")

main : IO ()
main = do
  result <- ocr "receipt.png" "/tmp/learn_idris_ch22_ex04"
  case result of
    Left e  => putStrLn ("error: " ++ e)
    Right t => putStrLn t
