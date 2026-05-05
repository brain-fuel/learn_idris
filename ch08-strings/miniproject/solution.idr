module Main

import Data.String
import Data.List
import Data.SortedMap

%default total

-- Word-Frequency Histogram starter file.
--
-- Behavior: read ONE line of stdin (a paragraph). Lowercase it, treat
-- the punctuation `,`, `.`, `!`, `?` as if it were a space, then split
-- on whitespace. Count occurrences of each word. Print one word per
-- line in the format `WORD: N`, sorted DESCENDING by count, then
-- ASCENDING by word as a tiebreaker.
--
-- Sample (input on stdin):
--     the quick brown fox. the lazy dog. the fox.
--
-- Expected output:
--     the: 3
--     fox: 2
--     brown: 1
--     dog: 1
--     lazy: 1
--     quick: 1
--
-- The framework below is mostly written. You only need to fix two
-- functions: `bump` (increment a count in the map) and `formatPairs`
-- (sort the (word, count) pairs and format them as strings).
--
-- TODO 1: in `bump`, replace `FIXME` with the right
--         `case lookup w m of ...` body so that a missing word starts at
--         1 and an existing word is incremented.
-- TODO 2: in `formatPairs`, replace `FIXME` with a `sortBy` call that
--         sorts by count descending, then word ascending. The lambda
--         shape that works:
--           \(w1, n1), (w2, n2) =>
--               case compare n2 n1 of
--                 EQ => compare w1 w2
--                 o  => o

cleanChar : Char -> Char
cleanChar c = if c == ',' || c == '.' || c == '!' || c == '?'
              then ' '
              else c

clean : String -> String
clean = pack . map cleanChar . unpack

bump : String -> SortedMap String Nat -> SortedMap String Nat
bump w m = m

countWords : List String -> SortedMap String Nat
countWords []        = empty
countWords (w :: ws) = bump w (countWords ws)

formatPairs : List (String, Nat) -> List String
formatPairs ps = []

main : IO ()
main = do
  line <- getLine
  let cleaned = toLower (clean line)
  let ws = words cleaned
  let counts = countWords ws
  let pairs = Data.SortedMap.toList counts
  for_ (formatPairs pairs) putStrLn
