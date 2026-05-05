module Main

%default total

-- New idea: a function can call itself -- that's recursion. Idris
-- checks that every recursive call is on a STRUCTURALLY SMALLER input,
-- so the recursion is guaranteed to stop.
--
-- Here we pattern-match on `Nat`: `Z` is zero, `S k` is "one more than
-- some k". When we see `S k`, we recurse on `k` -- which is one smaller
-- than `S k`. That's the whole rule.
--
-- TODO: replace `FIXME` with `countDown k` so the program counts
--       down from 5 and prints "lift off!" at zero.

countDown : Nat -> IO ()
countDown Z     = putStrLn "lift off!"
countDown (S k) = do
  printLn (S k)
  pure ()

main : IO ()
main = countDown 5
