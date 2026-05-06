module Main

import Data.List

%default total

-- Exercise 09: elapsed minutes between consecutive journal entries.
--
-- Given a `List Int` of minutes-since-midnight (from a parsed journal),
-- return the differences between consecutive elements.
--
-- Example: [540, 565, 570, 600, 645]  -- 09:00, 09:25, 09:30, 10:00, 10:45
--          -> [25, 5, 30, 45]
--
-- Hint: use `zip xs (drop 1 xs)` then map subtraction.
--
-- TODO: implement `elapsedFromJournal`.

elapsedFromJournal : List Int -> List Int
elapsedFromJournal _ = []

main : IO ()
main = do
  let xs : List Int
      xs = [540, 565, 570, 600, 645]
  printLn (elapsedFromJournal xs)
