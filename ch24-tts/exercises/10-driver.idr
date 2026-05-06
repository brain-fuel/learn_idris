module Main

import System
import System.File
import Data.String

%default total

-- New idea: tie the whole pipeline together. Read one line from stdin
-- (the text to speak), build a `SpeakReq`, run `speak`, then `validate`,
-- and print the result.
--
-- We deliberately keep stdout terse and grep-friendly so a test driver
-- can assert on substrings.
--
-- TODO: replace the `putStrLn "FIXME"` body with a real driver that:
--       1. reads one line via `getLine`
--       2. constructs a `SpeakReq` (text from stdin, hard-coded outFile)
--       3. shells `speak`
--       4. calls `validate` on the resulting WAV
--       5. prints `wrote <outFile>`, then the validate result.

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out =
  "espeak-ng -v en -w " ++ out ++ " " ++ shellQuote text

covering
speak : (text : String) -> (out : String) -> IO Int
speak text out = System.system (mkSpeakCmd text out)

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

isRiff : String -> Bool
isRiff s = wavMagic s == "RIFF"

covering
validate : String -> IO (Either String String)
validate path = do
  Right bytes <- readFile path
    | Left err => pure (Left ("read error: " ++ show err))
  if not (isRiff bytes)
    then pure (Left "missing RIFF header")
    else if length bytes <= 100
      then pure (Left ("too small: " ++ show (length bytes) ++ " bytes"))
      else pure (Right "ok")

record SpeakReq where
  constructor MkSpeakReq
  text    : String
  outFile : String

covering
main : IO ()
main = putStrLn "FIXME"
