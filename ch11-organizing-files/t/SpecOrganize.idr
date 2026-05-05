module Main

import System
import System.File
import Data.String
import Data.Maybe

-- Test driver for the Photo Organizer miniproject.
--
-- Spawns the solution as a subprocess, pipes the fixture stdin, captures
-- stdout, and asserts the expected lines appear.
--
-- Default target: ch11-organizing-files/miniproject/solution.idr (the LEARNER stub).
-- Override with the SOLUTION env var to test the _key/ reference instead.
--
-- Run from the repo root:
--   idris2 --no-banner --exec main ch11-organizing-files/t/SpecOrganize.idr
--   SOLUTION=ch11-organizing-files/miniproject/_key/solution.idr idris2 --no-banner --exec main ch11-organizing-files/t/SpecOrganize.idr

defaultSolution : String
defaultSolution = "ch11-organizing-files/miniproject/solution.idr"

fixturePath : String
fixturePath = "ch11-organizing-files/miniproject/fixtures/input.txt"

outPath : String
outPath = "/tmp/learn_idris_ch11_organize_out.txt"

cmd : (solution : String) -> String
cmd solution =
  "cat " ++ fixturePath ++ " | idris2 --no-banner --exec main " ++ solution ++ " > " ++ outPath ++ " 2>&1"

expected : List String
expected = [ "moved photo1.jpg -> images/photo1.jpg"
           , "moved note1.txt -> notes/note1.txt"
           , "moved clip.mov -> video/clip.mov"
           , "moved junk.bin -> other/junk.bin"
           ]

setupFixture : IO ()
setupFixture = do
  _ <- system "rm -rf /tmp/learn_idris_ch11_test"
  _ <- system "mkdir -p /tmp/learn_idris_ch11_test"
  _ <- system "touch /tmp/learn_idris_ch11_test/photo1.jpg /tmp/learn_idris_ch11_test/note1.txt /tmp/learn_idris_ch11_test/clip.mov /tmp/learn_idris_ch11_test/junk.bin"
  pure ()

checkOne : String -> String -> IO Bool
checkOne output needle =
  if isInfixOf needle output
    then do putStrLn ("ok    output contains \"" ++ needle ++ "\""); pure True
    else do putStrLn ("FAIL  output missing  \"" ++ needle ++ "\""); pure False

checkAll : String -> List String -> IO Nat
checkAll _      []        = pure Z
checkAll output (n :: ns) = do
  ok   <- checkOne output n
  rest <- checkAll output ns
  pure (if ok then rest else S rest)

partial
main : IO ()
main = do
  setupFixture
  envSol <- getEnv "SOLUTION"
  let solution = fromMaybe defaultSolution envSol
  putStrLn ("==> running miniproject: " ++ solution)
  _ <- system (cmd solution)
  Right output <- readFile outPath
    | Left err => do
        putStrLn ("FAIL  could not read " ++ outPath ++ ": " ++ show err)
        exitWith (ExitFailure 1)
  fails <- checkAll output expected
  case fails of
    Z => do
      putStrLn "PASS"
      exitWith ExitSuccess
    n => do
      putStrLn ("FAILED: " ++ show n ++ " missing")
      exitWith (ExitFailure 1)
