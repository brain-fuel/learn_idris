module Main

import System.File
import Data.String

%default total

-- Recap: pull together everything from this chapter.
--
-- Behavior:
--   1. Read `ch10-files/exercises/fixtures/three-lines.txt`.
--   2. Compute (#lines, #words). Use `lines` and `words` from
--      `Data.String`. Skip empty trailing lines (the file ends with
--      `\n`, which `lines` produces a trailing `""` for -- filter it).
--   3. Build the summary string `lines=N words=M\n`.
--   4. Write the summary to `/tmp/learn_idris_ch10_recap.txt`.
--   5. Print the summary to stdout (without the trailing newline --
--      `putStrLn` adds one for you).
--
-- The fixture has three one-word lines, so the expected stdout is:
--     lines=3 words=3
--
-- The stub below skips the file read AND skips the write, just printing
-- a wrong constant. Replace it with the full recap.
--
-- TODO: implement the five steps above. On any file error, print
--       `error: <show err>`.

main : IO ()
main = putStrLn "lines=0 words=0"
