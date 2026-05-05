module Main

%default total

-- New idea: `map f xs` runs `f` on every element of `xs` and gives back
-- the list of results. The shape of the list is unchanged; only the
-- values are transformed.
--
-- `[1..5]` is a range — short for `[1, 2, 3, 4, 5]`.
--
-- TODO: replace `FIXME` with `x * x` so the program prints the squares.

main : IO ()
main = printLn (map (\x => x) [1..5])
