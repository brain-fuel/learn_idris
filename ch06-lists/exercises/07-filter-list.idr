module Main

%default total

-- New idea: `filter pred xs` keeps only the elements where `pred x` is
-- `True`. The predicate has type `a -> Bool`.
--
-- On `Integer` there is no built-in `odd`, but `n `mod` 2 /= 0` works.
--
-- TODO: define `isOdd` and use `filter` to keep the odd numbers from
--       `[1..10]`. Replace the `FIXME` line with a real definition.

main : IO ()
main = printLn (filter (\x => True) [1..10])
