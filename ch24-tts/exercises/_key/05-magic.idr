module Main

import Data.String

%default total

wavMagic : String -> String
wavMagic s = pack (take 4 (unpack s))

main : IO ()
main = putStrLn (wavMagic "RIFFblahblahblah")
