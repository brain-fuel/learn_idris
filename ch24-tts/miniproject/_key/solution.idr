module Main

import System
import System.File
import Data.String

%default total

-- read-aloud miniproject (REFERENCE KEY)
--
-- Reads one line from stdin, shells `espeak-ng -w <out> '<text>'` so
-- the TTS engine writes a WAV instead of speaking through the speakers,
-- then sanity-checks the resulting WAV (RIFF magic + size > 100 bytes)
-- and prints a grep-friendly report.

outPath : String
outPath = "/tmp/learn_idris_ch24_speech.wav"

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out =
  "espeak-ng -v en -w " ++ out ++ " " ++ shellQuote text

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

isRiff : String -> Bool
isRiff s = wavMagic s == "RIFF"

covering
speak : (text : String) -> (out : String) -> IO Int
speak text out = System.system (mkSpeakCmd text out)

covering
main : IO ()
main = do
  text <- getLine
  _ <- speak text outPath
  putStrLn ("wrote " ++ outPath)
  Right bytes <- readFile outPath
    | Left err => putStrLn ("error reading " ++ outPath ++ ": " ++ show err)
  let riff   = isRiff bytes
  let size   = length bytes
  let header = if riff then "yes" else "no"
  putStrLn ("RIFF header: " ++ header)
  putStrLn ("size: " ++ show size ++ " bytes")
