module Main

import Data.String

%default total

-- New idea: equality on `String` is just `==`. We compare `wavMagic s`
-- against the literal `"RIFF"` and return a `Bool`.
--
-- TODO: implement `isRiff` so it returns `True` exactly when `wavMagic s`
--       equals `"RIFF"`. Replace the `False` placeholder.

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

isRiff : String -> Bool
isRiff s = False

main : IO ()
main = do
  printLn (isRiff "RIFFblahblah")
  printLn (isRiff "not a wav")
