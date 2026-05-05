module Main

import System

%default total

-- New idea: a program signals success or failure to its parent shell
-- via an `ExitCode`. `exitWith : ExitCode -> IO a` ends the program
-- and returns that code.
--
-- Python:    `sys.exit(7)`
-- Idris:     `exitWith (ExitFailure 7)`
--
-- `ExitSuccess` is code 0; `ExitFailure n` is code `n`. By default a
-- program that finishes normally exits 0.
--
-- TODO: print `going` and then call `exitWith (ExitFailure 7)`. If
-- you run this from a real shell and check `$?` afterward, it'll
-- be 7.

main : IO ()
main = do
  putStrLn "going"
  pure ()
