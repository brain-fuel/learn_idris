module Main

import Data.String
import Data.Maybe
import Data.List
import Data.Vect

%default total

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
  let scores = the (Vect 5 Integer) [s1, s2, s3, s4, s5]
  let tot = sum scores
  let avg = tot `div` 5
  let lo = foldr1 min scores
  let hi = foldr1 max scores
  let passing = length (filter (>= 60) (toList scores))
  putStrLn "count: 5"
  putStrLn ("average: " ++ show avg)
  putStrLn ("min: " ++ show lo)
  putStrLn ("max: " ++ show hi)
  putStrLn ("passing: " ++ show passing)
