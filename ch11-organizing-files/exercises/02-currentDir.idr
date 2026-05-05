module Main

import System.Directory

%default total

-- New idea: `currentDir : IO (Maybe String)` asks the OS for the
-- process's working directory. It can fail (rare; e.g., the cwd was
-- removed out from under you) so you get a `Maybe`.
--
-- TODO: print the current working directory; if `Nothing`, print
--       `(unknown)`.

main : IO ()
main = putStrLn "(unknown)"
