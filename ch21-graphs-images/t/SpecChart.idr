module Main

import System
import System.File
import Data.String
import Data.Maybe

-- Test driver for the Chart-from-TSV miniproject (chapter 21).
--
-- Spawns the solution as a subprocess, pipes the fixture stdin,
-- captures stdout, and asserts the expected substrings appear.
--
-- Default target: ch21-graphs-images/miniproject/solution.idr (the LEARNER stub).
-- Override with the SOLUTION env var to test the _key/ reference instead.
--
-- Run from the repo root:
--   idris2 --no-banner --exec main ch21-graphs-images/t/SpecChart.idr
--   SOLUTION=ch21-graphs-images/miniproject/_key/solution.idr idris2 --no-banner --exec main ch21-graphs-images/t/SpecChart.idr

defaultSolution : String
defaultSolution = "ch21-graphs-images/miniproject/solution.idr"

fixturePath : String
fixturePath = "ch21-graphs-images/miniproject/fixtures/input.txt"

outPath : String
outPath = "/tmp/learn_idris_ch21_chart_out.txt"

cmd : (solution : String) -> String
cmd solution =
  "cat " ++ fixturePath ++ " | idris2 --no-banner --exec main " ++ solution ++ " > " ++ outPath ++ " 2>&1"

expected : List String
expected = [ "wrote /tmp/learn_idris_ch21_chart.ppm"
           , "P3"
           , "20 10"
           , "255"
           ]

setupFixture : IO ()
setupFixture = do
  _ <- System.system "rm -f /tmp/learn_idris_ch21_chart.ppm"
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
  _ <- System.system (cmd solution)
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
