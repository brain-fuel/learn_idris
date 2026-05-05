module Main

import System

%default total

-- New idea: there is no `move` or `rename` in `System.Directory`. When
-- you want `mv`, shell out: `system "mv SRC DST"`. This is also how
-- you get atomic same-filesystem renames for free.
--
-- TODO: move `/tmp/learn_idris_ch11_ex09/from.txt` to
--       `/tmp/learn_idris_ch11_ex09/to.txt` via
--       `system "mv ..."`. On exit code 0 print `moved`, else
--       print `error`.
--
-- Note: the source file may not exist on a fresh clone — both stub and
-- key may print `error`. The point is the SHAPE.

main : IO ()
main = putStrLn "error"
