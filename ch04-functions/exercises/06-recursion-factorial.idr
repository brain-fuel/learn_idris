module Main

%default total

-- New idea: a function can call ITSELF -- that's recursion. The trick the
-- totality checker enforces is that the recursive call must be on a
-- structurally SMALLER input. For `Nat`, that means: pattern-match on
-- `S k` and recurse on `k`.
--
-- TODO: fill in the recursive case. `(S k) * fact k` is the body you want.

fact : Nat -> Nat
fact Z     = 1
fact (S k) = 1

main : IO ()
main = printLn (fact 5)
