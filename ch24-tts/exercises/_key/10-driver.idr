module Main

import System
import System.File
import Data.String

%default total

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
main = do
  line <- getLine
  let req = MkSpeakReq line "/tmp/learn_idris_ch24_ex10.wav"
  _ <- speak req.text req.outFile
  putStrLn ("wrote " ++ req.outFile)
  result <- validate req.outFile
  case result of
    Left reason => putStrLn ("validate: not ok: " ++ reason)
    Right ok    => putStrLn ("validate: " ++ ok)
