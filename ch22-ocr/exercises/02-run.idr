module Main

import System

%default total

-- New idea: `System.system : String -> IO Int` runs a shell command and
-- returns its exit code (0 on success, non-zero on failure).
--
-- We qualify the call as `System.system` so Idris doesn't confuse it
-- with `System.Escaped.system`, which takes a `List String` instead of
-- a single string.
--
-- TODO: build the command via `mkCmd` and run it via `System.system`.
-- Return the exit code. Replace the `pure 0` placeholder.

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

covering
ocrRun : (img : String) -> (out : String) -> IO Int
ocrRun img out = pure 0

main : IO ()
main = do
  code <- ocrRun "receipt.png" "/tmp/learn_idris_ch22_ex02"
  printLn code
