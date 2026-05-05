module Main

import System.Directory
import Data.String
import Data.List

%default total

-- Photo organizer starter file.
--
-- Behavior: read ONE line of stdin (a directory path). `listDir` it.
-- For each file, print `moved <filename> -> <category>/<filename>` to
-- stdout. Optionally also shell out (`mkdir -p`, `mv`) so that the
-- disk reflects what was printed. The test driver only checks stdout,
-- so you may skip the real `mv` calls if you want to focus on the
-- pure logic.
--
-- Sample (input on stdin):
--     /tmp/learn_idris_ch11_test
--
-- Expected output (after the test driver pre-creates the four files
-- photo1.jpg, note1.txt, clip.mov, junk.bin):
--     moved clip.mov   -> video/clip.mov
--     moved junk.bin   -> other/junk.bin
--     moved note1.txt  -> notes/note1.txt
--     moved photo1.jpg -> images/photo1.jpg
--
-- TODO 1: complete `extension` (see ch11 exercise 05).
-- TODO 2: complete `classify` (see ch11 exercise 06).
-- TODO 3: in `organizeOne`, print
--           "moved " ++ name ++ " -> " ++ category ++ "/" ++ name
--         Optionally also call `system` to actually move the file —
--         the test driver only checks stdout, so it's not required.

extension : String -> String
extension _ = ""

classify : String -> String
classify _ = "other"

organizeOne : (root : String) -> (name : String) -> IO ()
organizeOne root name = putStrLn "FIXME organize"

main : IO ()
main = do
  root <- getLine
  Right entries <- listDir root
    | Left _ => putStrLn "FIXME error"
  for_ (sort entries) (organizeOne root)
