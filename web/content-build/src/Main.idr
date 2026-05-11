module Main

import Data.List
import System
import ContentBuild.Scan
import ContentBuild.Emit
import ContentBuild.Assets

%default total

usage : String
usage = "usage: content-build <repoRoot> <routesOutPath> <assetsOutDir>"

covering
run : List String -> IO ()
run [_, repoRoot, routesOut, assetsOut] = do
  putStrLn ("scanning " ++ repoRoot)
  chs <- scanChapters repoRoot
  putStrLn ("found " ++ show (length chs) ++ " chapters")
  writeRoutesModule routesOut chs
  copyReadmes assetsOut chs
  putStrLn "OK"
run _ = do
  putStrLn usage
  exitWith (ExitFailure 1)

covering
main : IO ()
main = do
  args <- getArgs
  run args
