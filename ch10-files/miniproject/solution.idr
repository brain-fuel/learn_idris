module Main

import System.File
import Data.String

%default total

-- Daily Journal starter file.
--
-- The program reads commands from stdin one line at a time:
--   add SOMETHING    -- append "<timestamp> SOMETHING\n" to the journal
--                       file AND print "entry added: SOMETHING" to stdout.
--   show             -- read the journal file and print its contents.
--   clear            -- truncate the journal file and print
--                       "journal cleared".
--   quit             -- stop (an empty line also stops, for EOF).
--
-- The journal file lives at `journalPath` below (under `/tmp` so it
-- survives across runs but is ignored by git).
--
-- TODO 1: implement `addEntry` -- timestamp the entry with
--         `seconds <$> clockTime UTC` (you saw this in exercise 09),
--         build the line `show t ++ " " ++ text ++ "\n"`, append it to
--         `journalPath`, and print `"entry added: " ++ text`.
--         You will need to add `import System.Clock` at the top.
-- TODO 2: implement `showJournal` -- `readFile journalPath` and `putStr`
--         the contents. On `Left`, print
--         `(journal empty or missing)`.
-- TODO 3: implement `clearJournal` -- `writeFile journalPath ""` and
--         print `journal cleared`.
--
-- Why `partial`: `loop` recurses on user input, not a structurally
-- smaller value, so Idris cannot prove it terminates. `main` is
-- `partial` because it calls a `partial` function.

journalPath : String
journalPath = "/tmp/learn_idris_ch10_journal.txt"

addEntry : String -> IO ()
addEntry text = putStrLn "FIXME add"

showJournal : IO ()
showJournal = putStrLn "FIXME show"

clearJournal : IO ()
clearJournal = putStrLn "FIXME clear"

partial
loop : IO ()
loop = do
  line <- getLine
  let toks = words line
  case toks of
    [] => pure ()
    ["quit"] => pure ()
    ["show"] => do showJournal; loop
    ["clear"] => do clearJournal; loop
    ("add" :: rest) => do addEntry (unwords rest); loop
    _ => do putStrLn "?"; loop

partial
main : IO ()
main = loop
