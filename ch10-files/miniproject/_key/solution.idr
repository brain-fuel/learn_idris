module Main

import System.File
import System.Clock
import Data.String

%default covering

journalPath : String
journalPath = "/tmp/learn_idris_ch10_journal.txt"

now : IO Integer
now = map seconds (clockTime UTC)

addEntry : String -> IO ()
addEntry text = do
  t <- now
  let line = show t ++ " " ++ text ++ "\n"
  Right () <- appendFile journalPath line
    | Left e => putStrLn ("error: " ++ show e)
  putStrLn ("entry added: " ++ text)

showJournal : IO ()
showJournal = do
  Right contents <- readFile journalPath
    | Left _ => putStrLn "(journal empty or missing)"
  putStr contents

clearJournal : IO ()
clearJournal = do
  Right () <- writeFile journalPath ""
    | Left e => putStrLn ("error: " ++ show e)
  putStrLn "journal cleared"

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
