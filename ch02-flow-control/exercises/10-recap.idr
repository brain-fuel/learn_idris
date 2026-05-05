module Main

import Data.String
import Data.Maybe

%default total

-- New idea: a recap. Combine `getLine`, `parsePositive` (from
-- `Data.String`), and `case compare a b of` to compare two numbers
-- read from stdin.
--
--       parsePositive {a = Nat} "42"  ==  Just 42
--       parsePositive {a = Nat} "no"  ==  Nothing
--
-- `fromMaybe 0` (from `Data.Maybe`) unwraps a `Maybe Nat` with `0` as
-- the default when parsing fails.
--
-- TODO: replace each `putStrLn "FIXME"` with the right message so the
--       program prints `second wins` for `LT`, `tie` for `EQ`, and
--       `first wins` for `GT` (because `compare a b` answers "how does
--       a compare to b").

main : IO ()
main = do
  putStr "first number: "
  s1 <- getLine
  putStr "second number: "
  s2 <- getLine
  let a = fromMaybe 0 (parsePositive {a = Nat} s1)
  let b = fromMaybe 0 (parsePositive {a = Nat} s2)
  case compare a b of
    LT => putStrLn "FIXME"
    EQ => putStrLn "FIXME"
    GT => putStrLn "FIXME"
