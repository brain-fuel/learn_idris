module Main

import Data.String
import Data.Maybe
import Data.List
import Data.Vect

%default total

-- Score Statistics starter file.
--
-- The program reads exactly 5 integer scores from stdin, one per line,
-- then prints:
--   count: 5
--   average: <integer average>
--   min: <smallest>
--   max: <largest>
--   passing: <how many are >= 60>
--
-- Run with the fixture:
--   cat ch06-lists/miniproject/fixtures/input.txt \
--     | idris2 --no-banner --exec main ch06-lists/miniproject/solution.idr
--
-- TODO 1: replace the five `0`s so `scores` is built
--         from the five values you read in (`s1`..`s5`).
-- TODO 2: replace each `FIXME` in the `let` lines with a real
--         expression. Hints:
--           - `sum` over a `Vect` adds all the elements
--           - integer division is `` `div` ``
--           - `foldr1 min scores` works because `Vect 5 a` is non-empty
--           - `filter (>= 60) (toList scores)` keeps the passing scores
-- TODO 3: replace each `FIXME` `putStrLn` line with a real one of the
--         shape `putStrLn ("average: " ++ show avg)` etc.

readScore : IO Integer
readScore = do
  s <- getLine
  pure (fromMaybe 0 (parseInteger s))

main : IO ()
main = do
  s1 <- readScore
  s2 <- readScore
  s3 <- readScore
  s4 <- readScore
  s5 <- readScore
  let scores = the (Vect 5 Integer) [0, 0, 0, 0, 0]
  let tot = the Integer 0
  let avg = the Integer 0
  let lo = the Integer 0
  let hi = the Integer 0
  let passing = the Nat 0
  putStrLn "count: 5"
  putStrLn ("average: " ++ show avg)
  putStrLn ("min: " ++ show lo)
  putStrLn ("max: " ++ show hi)
  putStrLn ("passing: " ++ show passing)
