module ContentBuild.Assets

import Data.List
import System.Directory
import System.File
import ContentBuild.Scan

%default total

------------------------------------------------------------------------
-- Copy one chapter README to outDir/<slug>.md. Pure file copy via
-- read+write; we don't shell out so this stays portable.
------------------------------------------------------------------------

covering
copyOne : (outDir : String) -> Chapter -> IO ()
copyOne outDir ch = do
  Right body <- readFile ch.readmePath
    | Left err => putStrLn ("SKIP " ++ ch.slug ++ ": " ++ show err)
  let dest = outDir ++ "/" ++ ch.slug ++ ".md"
  Right () <- writeFile dest body
    | Left err => putStrLn ("FAIL writing " ++ dest ++ ": " ++ show err)
  pure ()

------------------------------------------------------------------------
-- Ensure outDir exists, then copy every chapter README into it.
------------------------------------------------------------------------

export covering
copyReadmes : (outDir : String) -> List Chapter -> IO ()
copyReadmes outDir chs = do
  _ <- createDir outDir
  -- ignore "already exists" failure; createDir surfaces other errors via
  -- the per-file write below.
  traverse_ (copyOne outDir) chs
  putStrLn ("copied " ++ show (length chs) ++ " assets -> " ++ outDir)
