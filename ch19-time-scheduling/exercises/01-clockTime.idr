module Main

import System.Clock

%default total

-- Exercise 01: clockTime
--
-- New idea: `clockTime : ClockType -> IO (Clock typ)` returns the
-- current time wrapped in IO. `UTC` asks for wall-clock time.
--
--     c <- clockTime UTC
--
-- The `Clock` record has two fields: `seconds : Integer` and
-- `nanoseconds : Integer`.
--
-- TODO: replace the body so it calls `clockTime UTC`, binds the result
-- to `c`, then prints `seconds c` AND `nanoseconds c` on two lines
-- (use `printLn` for each).

main : IO ()
main = putStrLn "FIXME"
