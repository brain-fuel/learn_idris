module Main

import System.File

%default total

-- New idea: a WAV that's only a few bytes long is always broken — even
-- a header alone is 44 bytes. So in addition to the magic bytes, we
-- check that the file has a reasonable length.
--
-- `length : String -> Nat` is in `Prelude` (String has a `Foldable`
-- instance, so `length` works on the bytes directly).
--
-- TODO: implement `wavSize` so it reads the file at `path` and returns
--       the byte length as a `Nat`. On a read error, return `0`.
--       Replace the `pure 0` placeholder.

covering
wavSize : String -> IO Nat
wavSize path = pure 0

covering
main : IO ()
main = do
  n <- wavSize "/tmp/learn_idris_ch24_ex03.wav"
  putStrLn ("size: " ++ show n)
