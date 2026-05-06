module Main

import System
import System.File

%default total

-- New idea: `xdotool getmouselocation` PRINTS its result to stdout.
-- Idris's `System.system` only gives us the exit code, not the
-- subprocess output. Workaround: ask the shell to redirect stdout to
-- a tempfile, then `readFile` the tempfile.
--
--       readXdotool "xdotool getmouselocation"
--       == run `xdotool getmouselocation > /tmp/learn_idris_ch23_tmp.txt`
--          read the file
--          return its contents
--
-- TODO: complete `readXdotool`:
--          let full = cmd ++ " > /tmp/learn_idris_ch23_tmp.txt"
--          _ <- System.system full
--          Right s <- readFile "/tmp/learn_idris_ch23_tmp.txt"
--            | Left _ => pure ""
--          pure s

covering
readXdotool : String -> IO String
readXdotool cmd = pure ""

main : IO ()
main = do
  s <- readXdotool "xdotool getmouselocation"
  putStrLn ("FIXME readXdotool got: " ++ s)
