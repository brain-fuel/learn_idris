module Main

%default total

-- New idea: `%default total` doesn't just check that you cover every
-- pattern -- it also checks that recursive calls are STRUCTURALLY
-- DECREASING. The recursive call must use a strictly smaller piece
-- of the input, so the compiler can prove the function terminates.
--
-- A naive `loop n = loop n` calls itself on the SAME `n`. That's not
-- smaller, and the compiler rejects it as not total. The fix is to
-- pattern-match on the `Nat` constructors (`Z` and `S k`) so the
-- recursive call uses `k`, which IS structurally smaller than `S k`.
--
-- This stub takes the easy way out: it just returns `0` for every
-- input, with no recursion at all. That typechecks (it's trivially
-- total), but it doesn't actually loop -- run the program and it
-- prints `0` regardless of the input. The point of the exercise is
-- the SHAPE of structural recursion.
--
-- TODO: rewrite `loop` so it pattern-matches on `Z` and `S k`. For
-- this exercise the bodies can both still return `0` -- what matters
-- is that the recursive case calls `loop k`, demonstrating structural
-- recursion the totality checker accepts.

loop : Nat -> Nat
loop n = 0

main : IO ()
main = printLn (loop 5)
