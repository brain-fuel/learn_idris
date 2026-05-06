module Main

import Data.String

%default total

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

isRiff : String -> Bool
isRiff s = wavMagic s == "RIFF"

main : IO ()
main = do
  printLn (isRiff "RIFFblahblah")
  printLn (isRiff "not a wav")
