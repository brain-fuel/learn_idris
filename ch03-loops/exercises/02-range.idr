module Main

%default total

-- New idea: `[1..5]` is shorthand for the list `[1, 2, 3, 4, 5]`. Both
-- ends are inclusive. Combined with `for_` it's the closest thing Idris
-- has to Python's `for i in range(...):`.
--
-- TODO: replace `FIXME` with `10` so the program prints 1 through 10.

main : IO ()
main = for_ [1..3] $ \i => printLn i
