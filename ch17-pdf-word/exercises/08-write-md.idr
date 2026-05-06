module Main

import System.File

%default total

-- New idea: once you've BUILT the Markdown string in memory, you write
-- it to disk with `writeFile : String -> String -> IO (Either FileError ())`.
-- File-IO callers must be marked `covering` (per-function), since
-- `writeFile` doesn't structurally recurse — the totality checker can't
-- prove termination through the FFI boundary.
--
-- TODO: replace `FIXME` so that `writeMd` actually writes `content` to
--       `path`. On success, return `Right ()`. On failure, propagate the
--       `Left err`.

covering
writeMd : (path : String) -> (content : String) -> IO (Either FileError ())
writeMd _ _ = pure (Right ())

covering
main : IO ()
main = do
  Right () <- writeMd "/tmp/learn_idris_ch17_ex08.md" "# FIXME\n"
    | Left err => putStrLn ("error: " ++ show err)
  putStrLn "wrote (FIXME)"
