module Main

import System
import System.File
import Data.String

%default total

-- read-aloud miniproject (LEARNER STUB)
--
-- Goal: read one line from stdin, shell `espeak-ng` to write a WAV at
-- `/tmp/learn_idris_ch24_speech.wav`, then validate the WAV by checking
-- the RIFF magic + size, and print:
--
--     wrote /tmp/learn_idris_ch24_speech.wav
--     RIFF header: yes
--     size: <N> bytes
--
-- The test driver greps stdout for "wrote /tmp/learn_idris_ch24_speech.wav"
-- and "RIFF". As shipped this stub prints `FIXME` placeholders — it
-- typechecks but the driver fails. Fill in the body to make it pass.

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
main : IO ()
main = do
  putStrLn "wrote FIXME"
  putStrLn "RIFF header: no"
  putStrLn "size: 0 bytes"
