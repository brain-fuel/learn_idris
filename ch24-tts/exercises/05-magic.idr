module Main

import Data.String

%default total

-- New idea: every WAV file begins with the four ASCII bytes `R`, `I`,
-- `F`, `F` — the "magic number" that identifies the format. Reading a
-- file's first 4 bytes and comparing them to `"RIFF"` is a cheap way to
-- sanity-check that espeak-ng actually produced a WAV.
--
-- `unpack : String -> List Char` and `pack : List Char -> String` are
-- inverses. `take 4 : List Char -> List Char` keeps the first four
-- elements (or fewer if the list is shorter).
--
-- TODO: implement `wavMagic` so it returns the first 4 characters of `s`
--       as a String. Use `unpack`, `take 4`, and `pack`.

wavMagic : String -> String
wavMagic s = ""

main : IO ()
main = putStrLn (wavMagic "RIFFblahblahblah")
