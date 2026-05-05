module Main

import Data.String

%default total

-- Recap: read ONE line of input, then print four facts about it:
--   1. its length (a `Nat`)
--   2. its lowercased version
--   3. the list of words in it
--   4. the count of non-space characters
--
-- The framework is sketched below. Each of the four `putStrLn` lines has
-- a `FIXME` that you must replace with the right call.
--
-- TODO: fix all four `FIXME`s. The helper `countNonSpace` is already
--       written for you; use it on the fourth line.

countNonSpace : String -> Nat
countNonSpace s = length (filter (/= ' ') (unpack s))

main : IO ()
main = do
  line <- getLine
  putStrLn ("length: " ++ show (id line))
  putStrLn ("lower: " ++ id line)
  putStrLn ("words: " ++ show (id line))
  putStrLn ("non-space chars: " ++ show (id line))
