module Main

import System
import System.File
import Data.String
import Data.Maybe

-- Test driver for the Address Book miniproject.
--
-- Spawns the solution as a subprocess, pipes the fixture stdin, captures
-- stdout, and asserts the three expected words appear.
--
-- Default target: ch07-dictionaries/miniproject/solution.idr (the LEARNER stub).
-- Override with the SOLUTION env var to test the _key/ reference instead.
--
-- Run from the repo root:
--   idris2 --no-banner --exec main ch07-dictionaries/t/SpecBook.idr
--   SOLUTION=ch07-dictionaries/miniproject/_key/solution.idr idris2 --no-banner --exec main ch07-dictionaries/t/SpecBook.idr

defaultSolution : String
defaultSolution = "ch07-dictionaries/miniproject/solution.idr"

fixturePath : String
fixturePath = "ch07-dictionaries/miniproject/fixtures/input.txt"

outPath : String
outPath = "/tmp/learn_idris_ch07_book_out.txt"

cmd : (solution : String) -> String
cmd solution =
  "cat " ++ fixturePath ++ " | idris2 --no-banner --exec main " ++ solution ++ " > " ++ outPath ++ " 2>&1"

expected : List String
expected = ["Alice: alice@x.com", "Bob: bob@y.com", "ok"]

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
