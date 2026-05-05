module Main

import System.Directory

%default total

-- New idea: `createDir : String -> IO (Either FileError ())` makes a
-- directory. It ERRORS if the directory already exists (it's not
-- `mkdir -p`). To be idempotent, check `exists` first. (`exists` ships
-- with `System.File.Meta`, which is re-exported by `System.Directory`.)
--
-- TODO: make `/tmp/learn_idris_ch11_ex03` if it doesn't exist. If
--       already there, print `already there`; if you created it, print
--       `created`.

main : IO ()
main = putStrLn "FIXME"
