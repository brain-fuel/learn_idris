module Main

import System
import System.Clock

%default total

-- Exercise 04: elapsed seconds across a sleep
--
-- Pattern: take a clock reading, do work, take another reading, subtract.
--
--     start <- clockTime UTC
--     -- ... work ...
--     end   <- clockTime UTC
--     let dt = seconds end - seconds start
--
-- TODO: take a clock reading, `sleep 1`, take another reading, then
-- print the difference (`seconds end - seconds start`). It should be
-- at least 1.

main : IO ()
main = printLn (the Integer 0)
