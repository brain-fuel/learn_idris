module Main

import Data.String
import Data.Maybe

%default total

fib : Nat -> Nat
fib Z         = 0
fib (S Z)     = 1
fib (S (S k)) = fib (S k) + fib k

main : IO ()
main = do
  putStr "How many? "
  raw <- getLine
  let n = fromMaybe 0 (parsePositive {a = Nat} raw)
  for_ [0 .. n] $ \i => printLn (fib i)
