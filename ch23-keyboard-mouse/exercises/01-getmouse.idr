module Main

import System

%default total

-- New idea: `xdotool` is a Linux command that asks the X server about
-- the mouse and keyboard. `xdotool getmouselocation` prints the cursor
-- position and exits 0. We shell out via `System.system` — same
-- pattern as ch11 (mkdir/mv) and ch22 (tesseract).
--
-- TODO: complete `getMouse` so it shells `xdotool getmouselocation`
--       and returns the exit code. Mark it `covering` because
--       `System.system` is an IO action that can't be proven total
--       structurally.
--
-- Hint:
--       code <- System.system "xdotool getmouselocation"
--       pure code

covering
getMouse : IO Int
getMouse = pure 0

main : IO ()
main = do
  code <- getMouse
  putStrLn ("FIXME getMouse exit=" ++ show code)
