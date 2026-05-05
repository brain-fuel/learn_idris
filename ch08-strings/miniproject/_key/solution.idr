module Main

import Data.String
import Data.List
import Data.SortedMap

%default total

cleanChar : Char -> Char
cleanChar c = if c == ',' || c == '.' || c == '!' || c == '?'
              then ' '
              else c

clean : String -> String
clean = pack . map cleanChar . unpack

bump : String -> SortedMap String Nat -> SortedMap String Nat
bump w m = case lookup w m of
             Nothing => insert w 1 m
             Just n  => insert w (n + 1) m

countWords : List String -> SortedMap String Nat
countWords []        = empty
countWords (w :: ws) = bump w (countWords ws)

formatPairs : List (String, Nat) -> List String
formatPairs ps =
  let sorted = sortBy (\(w1, n1), (w2, n2) =>
                        case compare n2 n1 of
                          EQ => compare w1 w2
                          o  => o) ps
  in map (\(w, n) => w ++ ": " ++ show n) sorted

main : IO ()
main = do
  line <- getLine
  let cleaned = toLower (clean line)
  let ws = words cleaned
  let counts = countWords ws
  let pairs = Data.SortedMap.toList counts
  for_ (formatPairs pairs) putStrLn
