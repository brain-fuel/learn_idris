module Main

import System.File
import Data.String

%default total

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

covering
main : IO ()
main = do
  result <- validate "/tmp/learn_idris_ch24_ex03.wav"
  case result of
    Left reason => putStrLn ("not ok: " ++ reason)
    Right ok    => putStrLn ok
