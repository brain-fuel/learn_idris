module Main

import System
import System.File
import Data.String
import Data.Maybe

-- Test driver for the Mouse-Mover miniproject.
--
-- Spawns the solution as a subprocess wrapped in `xvfb-run -a`, pipes
-- the fixture stdin, captures stdout, and asserts the expected lines
-- appear. The xvfb-run wrapper provides a virtual `:99` X display so
-- xdotool acts there — your real cursor is not touched.
--
-- Default target: ch23-keyboard-mouse/miniproject/solution.idr (the LEARNER stub).
-- Override with the SOLUTION env var to test the _key/ reference instead.
--
-- Run from the repo root:
--   idris2 --no-banner --exec main ch23-keyboard-mouse/t/SpecClick.idr
--   SOLUTION=ch23-keyboard-mouse/miniproject/_key/solution.idr idris2 --no-banner --exec main ch23-keyboard-mouse/t/SpecClick.idr

defaultSolution : String
defaultSolution = "ch23-keyboard-mouse/miniproject/solution.idr"

fixturePath : String
fixturePath = "ch23-keyboard-mouse/miniproject/fixtures/input.txt"

outPath : String
outPath = "/tmp/learn_idris_ch23_click_out.txt"

cmd : (solution : String) -> String
cmd solution =
  "xvfb-run -a sh -c 'cat " ++ fixturePath ++ " | idris2 --no-banner --exec main " ++ solution ++ " > " ++ outPath ++ " 2>&1'"

expected : List String
expected = [ "moved to 100 200"
           , "moved to 300 400"
           , "x:100"
           , "x:300"
           , "quit"
           ]

setupFixture : IO ()
setupFixture = do
  _ <- System.system "rm -f /tmp/learn_idris_ch23_tmp.txt /tmp/learn_idris_ch23_click_out.txt"
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
