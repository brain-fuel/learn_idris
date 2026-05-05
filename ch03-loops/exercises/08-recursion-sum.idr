module Main

%default total

-- New idea: the same trick works on lists. Pattern `[]` is empty,
-- `(x :: xs)` is "head x followed by tail xs". We recurse on `xs`,
-- which is one element shorter -- structurally smaller.
--
-- TODO: replace `FIXME` with `mySum xs` so we add `x` to the sum of
--       the rest.

mySum : List Nat -> Nat
mySum []        = 0
mySum (x :: xs) = x + 0

main : IO ()
main = printLn (mySum [1, 2, 3, 4, 5])
