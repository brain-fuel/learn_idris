module Main

import System

%default total

-- New idea: `System.system : String -> IO Int` runs a shell command and
-- returns its exit code. Qualifying as `System.system` (not just
-- `system`) prevents Idris from confusing it with `System.Escaped.system`
-- (which takes `List String` instead).
--
-- The function shells out, so it needs the `covering` annotation. We
-- can't prove totality on a process we don't control.
--
-- TODO: build the command via `mkSpeakCmd` and run it via `System.system`.
--       Return the exit code. Replace the `pure 0` placeholder.

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out =
  "espeak-ng -v en -w " ++ out ++ " " ++ shellQuote text

covering
speak : (text : String) -> (out : String) -> IO Int
speak text out = pure 0

covering
main : IO ()
main = do
  code <- speak "hello" "/tmp/learn_idris_ch24_ex03.wav"
  putStrLn ("exit: " ++ show code)
