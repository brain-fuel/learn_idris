module Main

import System.File

%default total

-- New idea: tesseract writes the OCR output to `<out>.txt`. To consume
-- the result from Idris we `readFile` that path. `readFile` returns
-- `IO (Either FileError String)` — we'll keep things simple and fall
-- back to `""` on Left.
--
-- TODO: replace `pure ""` with a `readFile` call on `out ++ ".txt"`
-- that returns the file contents on Right, or `""` on Left.

covering
readOcr : (out : String) -> IO String
readOcr out = pure ""

main : IO ()
main = do
  txt <- readOcr "/tmp/learn_idris_ch22_ex03"
  putStrLn txt
