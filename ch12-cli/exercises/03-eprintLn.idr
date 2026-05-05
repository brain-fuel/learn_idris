module Main

import System
import System.File
import System.File.Virtual

%default total

-- New idea: a process has TWO output streams — stdout (where normal
-- output goes) and stderr (where errors and progress messages go).
-- Tools like shells, pipes, and CI systems treat them differently.
--
-- Python:    `print("oops", file=sys.stderr)`
-- Idris:     `ignore $ fPutStrLn stderr "oops"`
--
-- The Idris stdlib does not export an `eprintLn`. The idiomatic move
-- is to call `fPutStrLn` against the `stderr` file handle from
-- `System.File.Virtual`. We `ignore` the result because `fPutStrLn`
-- returns an `Either FileError ()` we don't care about here.
--
-- TODO: print `this is stdout` to stdout via `putStrLn`, then print
-- `this is stderr` to stderr via `fPutStrLn stderr`.

main : IO ()
main = do
  putStrLn "this is stdout"
  putStrLn "this is stderr"
