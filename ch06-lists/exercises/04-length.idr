module Main

%default total

-- New idea: `length` counts how many elements a list has. The result is
-- a `Nat` (a non-negative whole number).
--
-- TODO: replace `FIXME` with the list `[10, 20, 30, 40]` so the program
--       prints `4`.

main : IO ()
main = printLn (length (the (List Int) []))
