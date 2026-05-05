module Main

import Data.String
import Data.Maybe

%default total

-- New idea: a recap. We define a recursive `fib` (Fibonacci numbers),
-- read N from the user, then `for_` over `[0..n]` printing each one.
-- Two recursive calls in one function -- still total, because both
-- recurse on something structurally smaller than `S (S k)`.
--
-- Note: `[0 .. n]` over `Nat` is INCLUSIVE on both ends, so we get
-- `n + 1` numbers. That's fine for this lesson.
--
-- TODO 1: replace `FIXME1` in `fib` with `fib (S k) + fib k`.
-- TODO 2: replace `FIXME2` in `main` with `n` so the loop ranges
--         from 0 to n.

fib : Nat -> Nat
fib Z         = 0
fib (S Z)     = 1
fib (S (S k)) = 0

main : IO ()
main = do
  putStr "How many? "
  raw <- getLine
  let n = fromMaybe 0 (parsePositive {a = Nat} raw)
  for_ [0 .. 0] $ \i => printLn (fib i)
