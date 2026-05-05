module Main

import System.Clock

%default total

-- New idea: `clockTime UTC : IO (Clock UTC)` gives the current wall
-- time as a `Clock` record. The projection `seconds : Clock t -> Integer`
-- pulls out the seconds-since-epoch component.
--
-- We will use this in the chapter miniproject to timestamp journal
-- entries.
--
-- TODO: replace `printLn 0` so the program prints the current Unix
--       timestamp (whatever `seconds` of `clockTime UTC` returns).

main : IO ()
main = printLn (the Integer 0)
