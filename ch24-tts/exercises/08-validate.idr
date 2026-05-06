module Main

import System.File
import Data.String

%default total

-- New idea: combine the previous checks into one validator. We say a
-- WAV is "ok" when:
--
--   * its first 4 bytes are `RIFF`
--   * AND its size is greater than 100 bytes
--
-- Anything else is suspicious. We return `Either String String` so the
-- caller learns WHY a file failed validation, not just that it did.
--
-- TODO: read the file, check the magic bytes via `isRiff`, check the
--       size, and return `Right "ok"` if both pass. Otherwise return
--       `Left "<reason>"`. Replace the `pure (Left "FIXME")` placeholder.

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

isRiff : String -> Bool
isRiff s = wavMagic s == "RIFF"

covering
validate : String -> IO (Either String String)
validate path = pure (Left "FIXME")

covering
main : IO ()
main = do
  result <- validate "/tmp/learn_idris_ch24_ex03.wav"
  case result of
    Left reason => putStrLn ("not ok: " ++ reason)
    Right ok    => putStrLn ok
