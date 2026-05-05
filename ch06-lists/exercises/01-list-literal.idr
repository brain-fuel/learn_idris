module Main

%default total

-- New idea: a `List a` is zero or more values, all of the same type `a`,
-- written with square brackets and commas: `[1, 2, 3]`. The empty list is
-- `[]`. Idris can't always guess which list type you mean from `[]`, so
-- you sometimes annotate with `the (List Nat) [...]` to be explicit.
--
-- TODO: replace `FIXME` so the list contains the numbers 1, 2, 3, 4, 5.

main : IO ()
main = printLn (the (List Nat) [])
