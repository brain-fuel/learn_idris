module Main

import System.Clock

%default total

-- Exercise 02: pull a single field out of the Clock record.
--
-- `seconds : Clock typ -> Integer` is the field accessor for the
-- `seconds` component of the Clock record. It is generated automatically
-- by Idris because the record declared the field by name.
--
-- TODO: replace the body so it calls `clockTime UTC`, then prints just
-- the `seconds` field with `printLn`. (No nanoseconds this time.)

getSeconds : IO Integer
getSeconds = pure 0

main : IO ()
main = do
  s <- getSeconds
  printLn s
