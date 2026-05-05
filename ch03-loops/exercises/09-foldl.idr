module Main

%default total

-- New idea: `foldl` is the general accumulator loop. Its shape is
-- `foldl step start xs` -- it walks `xs` left-to-right, carrying an
-- accumulator that starts at `start` and gets updated by `step` at
-- every element. `sum` is just `foldl (+) 0`; `product` is `foldl (*) 1`.
--
-- TODO: replace `FIXME` so the program prints 120 (which is 5!).
--       Hint: you want to multiply, and `(*)` is the multiplication
--       function in operator-as-function form.

main : IO ()
main = printLn (foldl const 1 [1..5])
