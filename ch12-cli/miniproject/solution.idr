module Main

import System
import System.File
import Data.String

%default total

-- ImageConverter (`ic`): a PPM-to-ASCII art converter.
--
-- Behavior:
--   * Read ONE line of stdin, formatted as
--         --in <path> --out <path> [--invert]
--   * Parse those flags into an `Opts` record.
--   * Validate that --in and --out were supplied.
--   * Read the PPM file at --in. The fixture's format is `P3` ASCII:
--         P3
--         <width> <height>
--         <maxval>
--         R G B  R G B  ...   (width*height triples)
--   * For each pixel, average the channels to get a brightness in
--     0..255. Map to a 10-character ramp: " .:-=+*#%@".
--     If `--invert`, reverse the ramp before mapping.
--   * Write the resulting ASCII art (one row per line) to --out.
--   * Print, to stdout: `wrote <out>: <width>x<height>`.
--
-- Why stdin instead of real argv? Because `idris2 --exec main` does
-- not pass user-supplied args through to your program. Reading a
-- single config line from stdin keeps the test harness uniform with
-- every other chapter.
--
-- Fixture (`miniproject/fixtures/tiny.ppm`):
--     P3
--     3 2
--     255
--     255 0 0   0 255 0   0 0 255
--       0 0 0   128 128 128   255 255 255
--
-- Driver stdin (`miniproject/fixtures/input.txt`):
--     --in ch12-cli/miniproject/fixtures/tiny.ppm --out /tmp/learn_idris_ch12_ic_out.txt
--
-- Expected stdout (substrings the driver checks for):
--     wrote /tmp/learn_idris_ch12_ic_out.txt
--     3x2
--
-- TODO 1: define `record Opts` with fields
--             input : String, output : String, invert : Bool
-- TODO 2: write `parseFlags : List String -> Opts -> Opts` (see ex06).
-- TODO 3: write `validate : Opts -> Either String Opts` (see ex07).
-- TODO 4: in `main`, read a line of stdin, parseFlags + validate,
--         then `readFile` the input PPM, render brightness/character
--         per pixel against the ramp `" .:-=+*#%@"` (reverse it if
--         `--invert`), `writeFile` the result to --out, and print
--         `wrote <out>: <w>x<h>` to stdout.

main : IO ()
main = do
  _ <- getLine
  putStrLn "FIXME wrote /tmp/output.txt"
  putStrLn "FIXME 0x0"
