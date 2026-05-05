module Main

import Data.String
import Data.SortedMap

%default total

-- Address Book starter file.
--
-- The program reads commands from stdin one line at a time:
--   add NAME EMAIL    -- add a contact
--   lookup NAME       -- print the contact, or `not found`
--   list              -- print every contact, sorted by name
--   quit              -- stop (an empty line also stops, for EOF)
--
-- TODO 1: in the `add` arm, replace `addArmFIXME` with code that
--         inserts `(name, MkContact email)` into `book`, prints `ok`,
--         and recurses with the updated book.
-- TODO 2: in the `list` arm, replace `listArmFIXME` with code that walks
--         `Data.SortedMap.toList book` with `for_` and prints each entry
--         using `showC`, then recurses with the same `book`.
--
-- Why `partial`: `loop` recurses on user input, not a structurally
-- smaller value. Idris cannot prove that statically, so we tag it
-- `partial`. `main` is `partial` because it calls a `partial` function.
-- This is the standard Idris pattern for read-eval-print loops.

record Contact where
  constructor MkContact
  email : String

showC : String -> Contact -> String
showC name c = name ++ ": " ++ c.email

Book : Type
Book = SortedMap String Contact

partial
loop : Book -> IO ()
loop book = do
  putStr "> "
  line <- getLine
  let toks = words line
  case toks of
    ["quit"] => pure ()
    [] => pure ()
    ("add" :: name :: email :: []) => do putStrLn "PLACEHOLDER"; loop book
    ("lookup" :: name :: []) =>
      case lookup name book of
        Just c  => do putStrLn (showC name c); loop book
        Nothing => do putStrLn "not found"; loop book
    ("list" :: []) => do putStrLn "PLACEHOLDER"; loop book
    _ => do putStrLn "?"; loop book

partial
main : IO ()
main = loop empty
