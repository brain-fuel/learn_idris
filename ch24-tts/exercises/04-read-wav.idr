module Main

import System.File

%default total

-- New idea: `readFile : String -> IO (Either FileError String)` works on
-- binary files too. Idris 2 treats `String` as a byte sequence at the
-- low level, so a WAV file (binary) round-trips fine through `readFile`
-- as long as we only inspect the bytes, not interpret them as text.
--
-- TODO: replace `pure (Left FileNotFound)` so that `readWav` calls
--       `readFile path` and returns its result directly.

covering
readWav : String -> IO (Either FileError String)
readWav path = pure (Left FileNotFound)

covering
main : IO ()
main = do
  result <- readWav "/tmp/learn_idris_ch24_ex03.wav"
  case result of
    Left err  => putStrLn ("error: " ++ show err)
    Right txt => putStrLn ("read " ++ show (length txt) ++ " bytes")
