module Main

import System
import System.File
import Data.String
import Data.List1

%default total

-- Mouse-mover starter file.
--
-- Behavior: read stdin line-by-line. Each line is `X Y` (two integers
-- separated by a space). For each line:
--     1. shell `xdotool mousemove X Y`
--     2. shell `xdotool getmouselocation` and capture its stdout
--     3. parse the output (e.g. "x:100 y:200 screen:0 window:1234")
--     4. print
--           moved to X Y
--           now at x:X y:Y
-- On EOF (empty getLine result) print `quit` and stop.
--
-- The test driver runs you under `xvfb-run -a` so xdotool acts on a
-- virtual display — it does NOT touch your real cursor when the test
-- harness is the caller. Run on `$DISPLAY=:0` directly and your real
-- cursor will move; that's how you know it works.
--
-- TODO 1: implement `mouseMove` (see exercise 03).
-- TODO 2: implement `readXdotool` (see exercise 06).
-- TODO 3: implement `parseMouseLine` (see exercise 07).
-- TODO 4: in `moveAndConfirm`, print the two real lines (see ex 09).
-- TODO 5: in `loop`, parse the stdin line and call `moveAndConfirm`,
--         then recurse. On EOF, print `quit`.

covering
mouseMove : Int -> Int -> IO Int
mouseMove _ _ = pure 0

covering
readXdotool : String -> IO String
readXdotool _ = pure ""

parseMouseLine : String -> Maybe (Int, Int)
parseMouseLine _ = Nothing

covering
moveAndConfirm : Int -> Int -> IO ()
moveAndConfirm _ _ = do
  putStrLn "moved to FIXME FIXME"
  putStrLn "now at x:FIXME y:FIXME"

partial
loop : IO ()
loop = do
  line <- getLine
  if line == ""
    then putStrLn "quit"
    else do
      moveAndConfirm 0 0
      loop

partial
main : IO ()
main = loop
