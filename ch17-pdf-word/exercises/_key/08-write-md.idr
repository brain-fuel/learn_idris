module Main

import System.File

%default total

covering
writeMd : (path : String) -> (content : String) -> IO (Either FileError ())
writeMd path content = writeFile path content

covering
main : IO ()
main = do
  Right () <- writeMd "/tmp/learn_idris_ch17_ex08.md" "# Hello\n\nWritten by Idris.\n"
    | Left err => putStrLn ("error: " ++ show err)
  putStrLn "wrote /tmp/learn_idris_ch17_ex08.md"
